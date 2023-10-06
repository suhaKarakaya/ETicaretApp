//
//  AuthenticateRequest.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 3.10.2023.
//

import Foundation
struct AuthenticateRequest: Codable {
    var username: String?
    var password: String?
    
    init(username: String? = "", password: String? = "") {
        self.username = username
        self.password = password
    }
}
