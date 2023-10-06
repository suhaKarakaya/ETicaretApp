//
//  Encodable.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 2.10.2023.
//

import Foundation

extension Encodable {

    public var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

    public var toJsonString: String? {
        guard let data = try? JSONEncoder().encode(self),
              let jsonString = String(data: data, encoding: .utf8) else { return nil }
        return jsonString
    }
    
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
