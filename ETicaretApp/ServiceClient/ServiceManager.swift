//
//  ServiceManager.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 2.10.2023.
//

import Foundation
import Alamofire

final class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {

    func fetch<T>(path: String, param: Parameters? = nil, method: HTTPMethod, headers: HTTPHeaders? = nil, encoding:   ParameterEncoding = URLEncoding.httpBody, onSuccess: @escaping (T) -> (), onError: @escaping (AFError?) -> ()) where T: Codable {
        AF.request(path, method: method, parameters: param, encoding: encoding, headers: headers).validate().responseDecodable(of : T.self) { response in
            guard let model = response.value else { return onError(response.error)  }
            onSuccess(model)
        }
    }

}


