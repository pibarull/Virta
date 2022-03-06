//
//  StationModel.swift
//  Virta
//
//  Created by Ilia Ershov on 02.03.2022.
//

import Foundation

struct StationModel: Decodable {

    var stations: [Station]
}

extension StationModel: Equatable {}
