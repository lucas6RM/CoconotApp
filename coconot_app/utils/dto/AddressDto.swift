//
//  AddressDto.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//


struct AddressDto: Codable, Hashable {
    let addressStreet: String
    let postalCode: String
    let city: String

    enum CodingKeys: String, CodingKey {
        case addressStreet = "address_street"
        case postalCode = "postal_code"
        case city
    }
}
