//
//  Connector.swift
//  Virta
//
//  Created by Ilia Ershov on 04.03.2022.
//

struct Connector: Hashable {

    var connectorID: Int?
    var type: String
    var maxKw: Int
    var currentType: String?
}

extension Connector: Decodable {

    enum CodingKeys: String, CodingKey {

        case connectorID
        case type
        case maxKw
        case currentType
    }
}

extension Connector: Equatable {}

extension Connector: Encodable {}
