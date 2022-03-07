//
//  StationViewModel.swift
//  Virta
//
//  Created by Ilia Ershov on 06.03.2022.
//

import Foundation

final class StationViewModel {

    weak var vc: StationViewController?

    private let virtaAPI: VirtaAPIClient = Injector.inject()

    func getStation() -> Station {
        return .init(id: 127033, latitude: 48.278067, longitude: 16.456204,
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
                                   groupName: "Default DEMS")])
    }
    
    func getStation(by id: Int, completion: @escaping () -> Void) -> Station? {
        let request = virtaAPI.request(VirtaAPI.getStation(by: id))
        
        var station: Station?
        
        request?.validate().responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                do {
                    station = try JSONDecoder().decode(Station.self, from: response.data!)

                    completion()
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })

        return station
    }
}
