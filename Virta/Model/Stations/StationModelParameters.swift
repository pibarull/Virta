//
//  StationModelParameters.swift
//  Virta
//
//  Created by Ilia Ershov on 04.03.2022.
//

struct StationsModelParameters {

    var lastUpdate: String
    var latMin: Float
    var latMax: Float
    var longMin: Float
    var longMax: Float
    var from: Int
    var limit: Int
    var privilegedStations: Int?
    var includePoi: Int
}

extension StationsModelParameters: Encodable {

    enum CodingKeys: String, CodingKey {

        case lastUpdate
        case latMin
        case latMax
        case longMin
        case longMax
        case from
        case limit
        case privilegedStations
        case includePoi
    }
}

extension StationsModelParameters: Equatable {}
