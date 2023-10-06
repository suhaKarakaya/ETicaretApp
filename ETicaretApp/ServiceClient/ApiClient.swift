//
//  ApiClient.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 2.10.2023.
//

import Foundation
import Alamofire


typealias foodsCallBack = (Foods?, Bool, String) -> Void
typealias cartCallBack = ([SepetYemekler]?, Bool, String) -> Void
typealias addCartCallBack = (Int, String) -> Void
typealias errorHandler = (AFError) -> Void
typealias authenticateCallBack = (AuthenticateResponse?, AFError?) -> Void
typealias deleteCartCallBack = (BaseResponse?) -> Void

protocol ApiClientProtocol {
    
    func fetchProductList(completion: @escaping foodsCallBack)
    func fetchCartList(param: Parameters, completion: @escaping cartCallBack)
    func addCart(param: Parameters, completion: @escaping addCartCallBack)
    func authenticate(param: Parameters, completion: @escaping authenticateCallBack)
    func deleteCart(param: Parameters, completion: @escaping deleteCartCallBack)
    func cleanBasket(params: [Parameters], completion: @escaping deleteCartCallBack)
}

public class ApiClient:ApiClientProtocol {
    
    static let shared: ApiClient = ApiClient()
}

extension ApiClient {
    
    func fetchProductList(completion: @escaping foodsCallBack) {
        ServiceManager.shared.fetch(path: Constants.kGETALLFOODSLINK, method: .get) { (response: Foods) in
            completion(response, true, "Success")
        } onError: { error in
            completion(nil, false, "Failure")
        }
    }
    
    func fetchCartList(param: Parameters, completion: @escaping cartCallBack) {
        ServiceManager.shared.fetch(path: Constants.kGETCARTLINK, param: param, method: .post) { (response: Cart) in
            completion(response.sepetYemekler, true, "Success")
        } onError: { error in
            completion(nil, false, "Failure")
        }
    }
    
    func addCart(param: Parameters, completion: @escaping addCartCallBack) {
        ServiceManager.shared.fetch(path: Constants.kADDCARTLINK, param: param, method: .post) { (response: BaseResponse) in
            completion(response.success, response.message)
        } onError: { error in
            completion(0, "Failure")
        }
    }
    
    func authenticate(param: Parameters, completion: @escaping authenticateCallBack) {
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        ServiceManager.shared.fetch(path: Constants.loginLink, param: param, method: .post, headers: headers, encoding: JSONEncoding.default) { response in
            completion(response, nil)
        } onError: { error in
            completion(nil, error)
        }
    }
    
    func deleteCart(param: Parameters, completion: @escaping deleteCartCallBack){
        ServiceManager.shared.fetch(path: Constants.kDELETECART, param: param, method: .post) { (response: BaseResponse) in
            completion(response)
        } onError: { error in
            completion(nil)
        }
        
    }
    
    func cleanBasket(params: [Parameters], completion: @escaping deleteCartCallBack) {
        var size = 0
        for param in params {
            deleteCart(param: param) { response in
                if response?.success == 1 {
                    size += 1
                    if size == params.count {
                        completion(BaseResponse.init(success: 1, message: ""))
                    }
                }
               

            }
        }
      
    }

}
