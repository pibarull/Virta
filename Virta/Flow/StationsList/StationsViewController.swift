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

final class StationsViewController: UITableViewController, CLLocationManagerDelegate {

    private var stationsViewModel = StationsViewModel()
    private lazy var virtaAPIClientService = VirtaAPIClientService()
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var stations: [Station] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableView.automaticDimension

        tableView.register(StationsViewCell.self,
                           forCellReuseIdentifier: Constants.stationsViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        stationsViewModel.vc = self
        stations = stationsViewModel.getStations()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            currentLocation = locationManager.location
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coordinate: CLLocation = .init(latitude: .init(stations[indexPath.row].latitude),
                                           longitude: .init(stations[indexPath.row].longitude))
        print(coordinate.coordinate.latitude)
        print(coordinate.coordinate.longitude)

        print(currentLocation?.coordinate.latitude)
        print(currentLocation?.coordinate.longitude)
        let distanceInMeters = Float(currentLocation?.distance(from: coordinate) ?? 0)
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.roundingMode = .halfEven
        formatter.decimalSeparator = ","
        let distanceString = formatter.string(from: NSNumber(value: distanceInMeters)) ?? ""
        print(distanceString)
        let stationsViewCell = StationsViewCellBuilder()
            .with(\.name, setTo: stations[indexPath.row].name)
            .with(\.city, setTo: stations[indexPath.row].city)
            .with(\.distance, setTo: "\(distanceString) m")
            .with(\.evses, setTo: stations[indexPath.row].evses)
            .build()

//        let stationsViewCell = dequeueProjectsListCell(tableView)
//        stationsViewCell.setUpCell(with: stations[indexPath.row],
//                                   onTap: () -> Void)

        return stationsViewCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }

    private func dequeueProjectsListCell(_ tableView: UITableView) -> StationsViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.stationsViewCellIdentifier)
        guard let stationsViewCell = cell as? StationsViewCell else {
            fatalError("Expected `StationsViewCell` to be registered")
        }

        return stationsViewCell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }

        let radius: Double = 350
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius * 1000.0, longitudinalMeters: radius * 1000.0)

        let minLat = location.coordinate.latitude - region.span.latitudeDelta
        let maxLat = location.coordinate.latitude + region.span.latitudeDelta
        let minLong = location.coordinate.longitude - region.span.longitudeDelta
        let maxLong = location.coordinate.longitude + region.span.longitudeDelta

//        print("minLat \(minLat)")
//        print("maxLat \(maxLat)")
//        print("minLong \(minLong)")
//        print("maxLong \(maxLong)")
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

//extension StationsViewController: UITableViewDelegate, UITableViewDataSource {
//}
