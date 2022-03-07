//
//  LocationProvider.swift
//  Virta
//
//  Created by Ilia Ershov on 07.03.2022.
//

import CoreLocation

protocol LocationProvider {

    func getCurrentLocation() -> CLLocation?

    func getCoordinatesForRequest(in radius: Double) -> (Double, Double, Double, Double)?

    func getDistanceFromCurrentLocation(to point: CLLocation) -> Double?
}

extension Injector where T == LocationProvider {

    static func inject() -> LocationProvider {
        return assembler.resolver.resolve(LocationProvider.self)!
    }
}
