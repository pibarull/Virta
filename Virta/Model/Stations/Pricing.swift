//
//  Pricing.swift
//  Virta
//
//  Created by Ilia Ershov on 07.03.2022.
//

import Foundation

enum Currency: String, Codable {

    case euro = "EUR"
    case dollar = "USD"

    enum CodingKeys: String, CodingKey {

        case euro
        case dollar
    }
}

struct Pricing: Hashable {

    var name: String
    var priceCents: Double
    var currency: Currency
}

extension Pricing: Decodable {

    enum CodingKeys: String, CodingKey {

        case name
        case priceCents
        case currency
    }
}

extension Pricing: Equatable {}

extension Pricing: Encodable {}
