//
//  StringExtension.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 3.10.2023.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
    var toInt: Int {
        return Int(self) ?? 0
    }
}

