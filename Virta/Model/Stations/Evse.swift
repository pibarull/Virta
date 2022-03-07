//
//  Evse.swift
//  Virta
//
//  Created by Ilia Ershov on 04.03.2022.
//

struct Evse: Hashable {

    var id: Int
    var connectors: [Connector]
    var pricing: [Pricing]?
    var groupName: String
}

extension Evse: Decodable {

    enum CodingKeys: String, CodingKey {

        case id
        case connectors
        case groupName
    }
}

extension Evse: Equatable {}

extension Evse: Encodable {}

