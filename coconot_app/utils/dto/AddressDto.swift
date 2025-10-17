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

    init(_ model: Address) {
        self.addressStreet = model.addressStreet
        self.postalCode = model.postalCode
        self.city = model.city
    }
}
