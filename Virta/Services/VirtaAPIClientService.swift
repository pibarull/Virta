//
//  VirtaAPIClientService.swift
//  Virta
//
//  Created by Ilia Ershov on 01.03.2022.
//

import Alamofire
import Foundation

final class VirtaAPIClientService {
    
    private let baseURL = URL(string: "https://apitest.virta.fi/v4")
}

extension VirtaAPIClientService: VirtaAPIClient {

    func request<In: Encodable, Out: Decodable>(_ endpoint: VirtaAPIEndpoint<In, Out>) -> DataRequest? {
        guard let url = baseURL?.appendingPathComponent(endpoint.path) else { return nil }
        let apiRequest = AF.request(url,
                                    method: endpoint.method,
                                    parameters: endpoint.requestData,
                                    encoder: JSONParameterEncoder.default)

        return apiRequest
    }

    func request<Out: Decodable>(_ endpoint: VirtaAPIEndpoint<Never, Out>) -> DataRequest? {
        guard let url = baseURL?.appendingPathComponent(endpoint.path) else { return nil }
        let apiRequest = AF.request(url, method: endpoint.method)

        return apiRequest
    }
}

