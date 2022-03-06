//
//  Station.swift
//  Virta
//
//  Created by Ilia Ershov on 04.03.2022.
//

struct Station {

    var id: Int
    var latitude: Float
    var longitude: Float
    var name: String
    var city: String
    var provider: String
    var evses: [Evse]
}

extension Station: Decodable {

    enum CodingKeys: String, CodingKey {

        case id
        case latitude
        case longitude
        case name
        case city
        case provider
        case evses
    }
}

extension Station: Equatable {}

extension Station: Encodable {}
