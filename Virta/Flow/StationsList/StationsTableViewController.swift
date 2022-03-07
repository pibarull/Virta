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
    private lazy var virtaAPIClientService = VirtaAPIClientService()
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var stations: [Station] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLocationManager()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(StationsViewCell.self,
                           forCellReuseIdentifier: Constants.stationsViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        stationsViewModel.vc = self
        stations = stationsViewModel.getStations()

        stations.sort { lhs, rhs in
            let coordinateLhs: CLLocation = .init(latitude: .init(lhs.latitude),
                                               longitude: .init(lhs.longitude))
            let coordinateRhs: CLLocation = .init(latitude: .init(rhs.latitude),
                                               longitude: .init(rhs.longitude))
            let distanceLhs = Float(currentLocation?.distance(from: coordinateLhs) ?? 0)
            let distanceRhs = Float(currentLocation?.distance(from: coordinateRhs) ?? 0)
            return distanceLhs < distanceRhs
        }
    }

    private func setUpLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            currentLocation = locationManager.location
        }
    }
}

extension StationsTableViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coordinate: CLLocation = .init(latitude: .init(stations[indexPath.row].latitude),
                                           longitude: .init(stations[indexPath.row].longitude))

        let distanceInMeters = Double(currentLocation?.distance(from: coordinate) ?? 0)

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
}
