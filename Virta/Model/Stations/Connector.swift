//
//  Connector.swift
//  Virta
//
//  Created by Ilia Ershov on 04.03.2022.
//

struct Connector: Hashable {

    var type: String
    var maxKw: Int
}

extension Connector: Decodable {

    enum CodingKeys: String, CodingKey {

        case type
        case maxKw
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try! container.decode(String.self, forKey: .type)
        maxKw = try! container.decode(Int.self, forKey: .maxKw)
    }
}

extension Connector: Equatable {}

extension Connector: Encodable {}
