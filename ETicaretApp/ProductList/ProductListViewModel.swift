//
//  ProductListViewModel.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 3.10.2023.
//

import Foundation

protocol ProductListViewModelInterface {
    func getProductList()
    func setCartData(_ cart: Yemekler, _ adet: String)
}
class ProductListViewModel: ProductListViewModelInterface{
    weak var view: ProductListViewControllerInterface?
    func getProductList() {
        view?.showSpinner()
        ApiClient.shared.fetchProductList(completion: getProductListHandler)
    }
    
    func setCartData(_ cart: Yemekler, _ adet: String){
        let param = AddCartRequest.init(yemek_adi: cart.yemekAdi ?? "", yemek_fiyat: cart.yemekFiyat ?? "", yemek_siparis_adet: adet, yemek_resim_adi: cart.yemekResimAdi ?? "", kullanici_adi: Constants.token).toDictionary
        ApiClient.shared.addCart(param: param ?? [:]) { [weak self] _status, _message in
            if _status == 1 {
                self?.view?.refreshList()
            } else {
                self?.view?.showErrorMessage("An error occurred during your operation!")
            }
        }
    }
    
    private func getProductListHandler(data: Foods?, status: Bool, message: String) {
        view?.hideSpinner()
        if !status {
            view?.showErrorMessage("An error occurred during your operation!")
        }
        guard let list = data?.yemekler else { return }
        getCartData(productList: list)
    }
    
    private func getCartData(productList: [Yemekler]){
        let param = CartRequest.init(kullanici_adi: Constants.token).toDictionary
        ApiClient.shared.fetchCartList(param: param ?? [:]) { [weak self] cartList, status, message in
            self?.view?.hideSpinner()
            if let tempList = cartList, !tempList.isEmpty {
                self?.view?.setTableViewData(tbList: self?.productListMap(productList, self?.cartListMap(tempList) ?? []) ?? [], cartList: self?.cartListMap(tempList) ?? [])
            } else {
                self?.view?.setTableViewData(tbList: productList, cartList: [])
            }
        }
    }
    
    private func cartListMap(_ list: [SepetYemekler]) -> [SepetYemekler] {
        var tempCartList:[SepetYemekler] = []
        for item in list {
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
        return tempCartList
    }
    
    private func productListMap(_ list: [Yemekler], _ cartList: [SepetYemekler]) -> [Yemekler]{
        var tempProductList: [Yemekler] = []
        var tempCartList2:[SepetYemekler] = []
        for item in list{
            if let index = cartList.firstIndex(where: { $0.yemekAdi == item.yemekAdi }) {
                var obj = item
                obj.stock -= cartList[index].adet
                tempProductList.append(obj)
                
                var objCart = cartList[index]
                objCart.stok = obj.stock
                tempCartList2.append(objCart)
                
            } else {
                tempProductList.append(item)
            }
        }
        return tempProductList
    }
}


