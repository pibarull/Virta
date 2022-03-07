//
//  StationsViewModel.swift
//  Virta
//
//  Created by Ilia Ershov on 03.03.2022.
//

import Foundation
import CoreLocation

final class StationsViewModel: NSObject {

    weak var vc: StationsTableViewController?

    private let virtaAPI: VirtaAPIClient = Injector.inject()
    private let locationProvider: LocationProvider = Injector.inject()

    func getStations() -> [Station] {
        return [
            .init(id: 127033, latitude: 48.278067, longitude: 16.456204,
                  name: "BIP P&R Leopoldau Station 2", city: "Wien", provider: "Hubject",
                  evses: [.init(id: 127033,
                                connectors: [.init(type: "Mennekes", maxKw: 22)],
                                groupName: "Default DEMS"),
                          .init(id: 126984,
                                connectors: [.init(type: "Type F", maxKw: 16)],
                                groupName: "Default DEMS"),
                          .init(id: 126932,
                                connectors: [.init(type: "Mennekes", maxKw: 22)],
                                groupName: "Default DEMS"),
                          .init(id: 127005,
                                connectors: [.init(type: "Type F", maxKw: 16)],
                                groupName: "Default DEMS")]),
            .init(id: 121952, latitude: 48.757137, longitude: 9.313445,
                  name: "EnBW Ladestation 3175_1", city: "Esslingen", provider: "Hubject",
                  evses: [.init(id: 121952,
                                connectors: [.init(type: "Mennekes", maxKw: 22),
                                             .init(type: "Type F", maxKw: 16)],
                                groupName: "Default DEMS"),
                          .init(id: 121439,
                                connectors: [.init(type: "Mennekes", maxKw: 22),
                                             .init(type: "Type F", maxKw: 16)],
                                groupName: "Default DEMS"),
                          .init(id: 126932,
                                connectors: [.init(type: "Mennekes", maxKw: 22)],
                                groupName: "Default DEMS")]),
            .init(id: 118737, latitude: 49.731636, longitude: 10.147702,
                  name: "Innopark Lademeile", city: "Kitzingen", provider: "Hubject",
                  evses: [.init(id: 118737,
                                connectors: [.init(type: "Mennekes", maxKw: 22)],
                                groupName: "Default DEMS"),
                          .init(id: 118738,
                                connectors: [.init(type: "Mennekes", maxKw: 22)],
                                groupName: "Default DEMS"),
                          .init(id: 113072,
                                connectors: [.init(type: "Type F", maxKw: 16)],
                                groupName: "Default DEMS"),
                          .init(id: 113073,
                                connectors: [.init(type: "Mennekes", maxKw: 22)],
                                groupName: "Default DEMS")])
        ]
    }

    func getStations(completion: @escaping () -> Void) -> [Station]? {
        guard let (latMin, latMax, longMin, longMax) = locationProvider.getCoordinatesForRequest(in: 350) else { return nil }

        let request = virtaAPI.request(VirtaAPI.getStations(
            .init(lastUpdate: "01.01.2022",
                  latMin: latMin,
                  latMax: latMax,
                  longMin: longMin,
                  longMax: longMax,
                  from: 0,
                  limit: 10,
                  privilegedStations: nil,
                  includePoi: 0)))

        var stations: [Station]?

        request?.validate().responseJSON(completionHandler: { [weak self] response in
            switch response.result {
            case .success(_):
                do {
                    stations = try JSONDecoder().decode([Station].self, from: response.data!)

                    completion()
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })

        let currentLocation = locationProvider.getCurrentLocation()

        stations?.sort { lhs, rhs in
            let coordinateLhs: CLLocation = .init(latitude: .init(lhs.latitude),
                                               longitude: .init(lhs.longitude))
            let coordinateRhs: CLLocation = .init(latitude: .init(rhs.latitude),
                                               longitude: .init(rhs.longitude))
            let distanceLhs = Float(currentLocation?.distance(from: coordinateLhs) ?? 0)
            let distanceRhs = Float(currentLocation?.distance(from: coordinateRhs) ?? 0)
            return distanceLhs < distanceRhs
        }

        return stations
    }
}
