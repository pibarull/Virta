//
//  StationsViewController.swift
//  Virta
//
//  Created by Ilia Ershov on 02.03.2022.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

private enum Constants {

    static var stationsViewCellIdentifier = "StationsViewCell"
}

final class StationsTableViewController: UITableViewController, CLLocationManagerDelegate {

    private var stationsViewModel = StationsViewModel()
    private let locationProvider: LocationProvider = Injector.inject()
    private var stations: [Station] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(StationsViewCell.self,
                           forCellReuseIdentifier: Constants.stationsViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        stationsViewModel.vc = self
        stations = stationsViewModel.getStations()
    }
}

extension StationsTableViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let point: CLLocation = .init(latitude: .init(stations[indexPath.row].latitude),
                                      longitude: .init(stations[indexPath.row].longitude))

        let distanceInMeters = locationProvider.getDistanceFromCurrentLocation(to: point)

        let lengthRepresenter = LengthRepresenter(unitOfMeasure: .meters)
        let distanceString = lengthRepresenter.present(representableValue: distanceInMeters)

        let stationsViewCell = StationsViewCellBuilder()
            .with(\.name, setTo: stations[indexPath.row].name)
            .with(\.city, setTo: stations[indexPath.row].city)
            .with(\.distance, setTo: distanceString)
            .with(\.evses, setTo: stations[indexPath.row].evses)
            .build()

        return stationsViewCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stationId = stations[indexPath.row].id
        let vc = StationViewController(stationId: stationId)

        navigationController?.pushViewController(vc, animated: true)
    }
}
