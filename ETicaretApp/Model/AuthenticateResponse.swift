//
//  AuthenticateResponse.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 3.10.2023.
//

import Foundation

// MARK: - AuthenticateResponse
struct AuthenticateResponse: Codable {
    let id: Int?
    let username, email, firstName, lastName: String?
    let gender: String?
    let image: String?
    let token: String?
}
