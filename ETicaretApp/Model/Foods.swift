//
//  Product.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 2.10.2023.
//

import Foundation

// MARK: - Foods
struct Foods: Codable {
    var yemekler: [Yemekler]?
    let success: Int?
}

// MARK: - Yemekler
struct Yemekler: Codable {
    let yemekID, yemekAdi, yemekResimAdi, yemekFiyat: String?
    var stock:Int = 10
    
    enum CodingKeys: String, CodingKey {
        case yemekID = "yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
    }
    
    mutating func changeValue(val: Int) {
        stock -= val
    }
}
