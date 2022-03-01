//
//  VirtaAPIClient.swift
//  Virta
//
//  Created by Ilia Ershov on 01.03.2022.
//

import Alamofire

/// Describes a REST HTTP client which could work with Virta REST API.

protocol VirtaAPIClient {

    func request<In: Encodable, Out: Decodable>(_ endpoint: VirtaAPIEndpoint<In, Out>) -> DataRequest?

    func request<Out: Decodable>(_ endpoint: VirtaAPIEndpoint<Never, Out>) -> DataRequest?
}
