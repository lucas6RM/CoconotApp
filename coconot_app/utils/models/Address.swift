//
//  Address.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//


struct Address: Codable, Hashable {
    var addressStreet: String
    var postalCode: String
    var city: String
    
    func getFullAddress() -> String {
        return "\(addressStreet) \(postalCode) \(city)"
    }
}