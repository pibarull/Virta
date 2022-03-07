//
//  LocationService.swift
//  Virta
//
//  Created by Ilia Ershov on 07.03.2022.
//

import MapKit
import CoreLocation

final class LocationService {

    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?

    init() {
        setUpLocationManager()
    }

    private func setUpLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            self.currentLocation = locationManager.location
        }
    }
}

extension LocationService: LocationProvider {

    func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }

    func getCoordinatesForRequest(in radius: Double) -> (Double, Double, Double, Double)? {
        guard let location: CLLocation = locationManager.location else { return nil }

        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius * 1000.0, longitudinalMeters: radius * 1000.0)

        let minLat = location.coordinate.latitude - region.span.latitudeDelta
        let maxLat = location.coordinate.latitude + region.span.latitudeDelta
        let minLong = location.coordinate.longitude - region.span.longitudeDelta
        let maxLong = location.coordinate.longitude + region.span.longitudeDelta

        return (minLat, maxLat, minLong, maxLong)
    }

    func getDistanceFromCurrentLocation(to point: CLLocation) -> Double? {
        return currentLocation?.distance(from: point)
    }
}
