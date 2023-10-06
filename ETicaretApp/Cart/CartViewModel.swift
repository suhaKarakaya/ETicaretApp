//
//  CartViewModel.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 3.10.2023.
//

import Foundation
import Alamofire

protocol CartViewModelInterface {
    func calculateTotalAndDisplayTableView(_ list: [SepetYemekler])
    func basketControl(_ list: [SepetYemekler], _ msg: String)
}

class CartViewModel: CartViewModelInterface {
    weak var view: CartViewControllerInterface?

    func calculateTotalAndDisplayTableView(_ list: [SepetYemekler]) {
        if list.isEmpty {
            view?.setTableViewData(foods: list, value: "0")
        } else {
            var total = 0
            for item in list {
                total += ((item.yemekFiyat?.toInt ?? 0) * (item.adet))
            }
            let strTotal = total.stringValue
            view?.setTableViewData(foods: list, value: strTotal)
        }
    }

    private func confirmCart(_ list: [SepetYemekler], _ msg: String) {
        view?.showCompletionAlert(title: "Warning", msg: msg, buttonTitle1: "Yes", buttonTitle2: "No", completion: { isConfirm in
            if isConfirm {
                var paramList:[Parameters] = []
                for item in list {
                    for item2 in item.sepetIdList {
                        paramList.append(DeleteCartRequest.init(sepet_yemek_id: item2, kullanici_adi: Constants.token).toDictionary ?? [:])
                    }
                }
                self.deleteCart(paramList)
            }
        })
    }
    
    
    
    private func deleteCart(_ paramList: [Parameters]) {
        self.view?.showSpinner()
        ApiClient.shared.cleanBasket(params: paramList) { [weak self] response in
            self?.view?.hideSpinner()
            if response?.success == 1 {
                self?.view?.getCartData()
            }
        }
    }
    
    func refreshData(){
        let param = CartRequest.init(kullanici_adi: Constants.token).toDictionary
        ApiClient.shared.fetchCartList(param: param ?? [:]) { [weak self] cartList, status, message in
            self?.view?.hideSpinner()
            if let tempList = cartList, !tempList.isEmpty {
                var tempCartList:[SepetYemekler] = []
                for item in tempList {
                    if let index = tempCartList.firstIndex(where: { $0.yemekAdi == item.yemekAdi }) {
                        var obj = tempCartList[index]
                        obj.adet += item.yemekSiparisAdet.toInt
                        var cList = tempCartList[index].sepetIdList
                        cList.append(item.sepetYemekID ?? "")
                        obj.sepetIdList = cList
                        tempCartList[index] = obj
                    } else {
                        var obj = item
                        obj.adet = item.yemekSiparisAdet.toInt
                        let newList = [item.sepetYemekID ?? ""]
                        obj.sepetIdList = newList
                        tempCartList.append(obj)
                    }
                }
                self?.calculateTotalAndDisplayTableView(tempCartList)
            } else {
                self?.calculateTotalAndDisplayTableView([])
            }
        }
    }
    
    func basketControl(_ list: [SepetYemekler], _ msg: String) {
        if list.isEmpty {
            view?.showDefaultAlert(title: "Warning", msg: "Cart is empty!", buttonTitle: "Ok")
        } else {
            confirmCart(list, msg)
        }
    }
    
    
}
