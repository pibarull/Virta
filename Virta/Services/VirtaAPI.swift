//
//  VirtaAPI.swift
//  Virta
//
//  Created by Ilia Ershov on 01.03.2022.
//

/// `VirtaAPI` is a scope for different types of `VirtaAPIEndpoint`.
///
/// Example:
///
///     Auth        -> "/auth"

enum VirtaAPI {

    static func setAuthData(_ authModelParameters: AuthModelParameters)
    -> VirtaAPIEndpoint<AuthModelParameters, AuthModel> {
        return .init(path: "/auth", method: .post, requestData: authModelParameters)
    }

    static func getStations(_ stationsModelParameters: StationsModelParameters) -> VirtaAPIEndpoint<StationsModelParameters, StationModel> {
        return .init(path: "/stations", method: .get, requestData: stationsModelParameters)
    }

    static func getStation(by stationId: Int) -> VirtaAPIEndpoint<Never, StationModel> {
        return .init(path: "/\(stationId)")
    }
}
