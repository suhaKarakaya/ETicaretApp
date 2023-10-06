//
//  Cart.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 2.10.2023.
//

import Foundation

// MARK: - Cart
struct Cart: Codable {
    let sepetYemekler: [SepetYemekler]?
    let success: Int?

    enum CodingKeys: String, CodingKey {
        case sepetYemekler = "sepet_yemekler"
        case success
    }
}

// MARK: - SepetYemekler
struct SepetYemekler: Codable {
    let sepetYemekID, yemekAdi, yemekResimAdi, yemekFiyat, kullaniciAdi: String?
    var yemekSiparisAdet: String
    var adet: Int = 0
    var stok: Int = 0
    var sepetIdList: [String] = []

    enum CodingKeys: String, CodingKey {
        case sepetYemekID = "sepet_yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
        case yemekSiparisAdet = "yemek_siparis_adet"
        case kullaniciAdi = "kullanici_adi"
    }
    
    mutating func changeValue(val: Int) {
        var tempValue = yemekSiparisAdet.toInt
        tempValue += val
        yemekSiparisAdet = tempValue.stringValue
    }
}

struct CartRequest: Codable {
    let kullanici_adi: String
}

struct DeleteCartRequest: Codable {
    let sepet_yemek_id: String
    let kullanici_adi: String
}
