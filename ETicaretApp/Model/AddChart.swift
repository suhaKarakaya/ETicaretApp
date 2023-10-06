//
//  AddCartResponse.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 2.10.2023.
//

import Foundation

struct AddCartRequest: Codable {
    let yemek_adi: String
    let yemek_fiyat: String
    let yemek_siparis_adet: String
    let yemek_resim_adi: String
    let kullanici_adi: String
}

struct BaseResponse: Codable {
    let success: Int
    let message: String
}
