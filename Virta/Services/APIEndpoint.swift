//
//  APIEndpoint.swift
//  Virta
//
//  Created by Ilia Ershov on 01.03.2022.
//

import Alamofire

/// An `APIEndpoint` represents REST API endpoints.
class APIEndpoint<RequestData, ResponseData> {

    let path: String
    let method: HTTPMethod
    let requestData: RequestData?

    init(path: String, method: HTTPMethod, requestData: RequestData?) {
        self.method = method
        self.path = path
        self.requestData = requestData
    }
}

extension APIEndpoint where RequestData: Encodable, ResponseData: Decodable {

    convenience init(path: String, method: HTTPMethod, reqData: RequestData) {
        self.init(path: path, method: method, requestData: reqData)
    }
}

extension APIEndpoint where RequestData == Never, ResponseData: Decodable {

    convenience init(path: String, method: HTTPMethod = .get) {
        self.init(path: path, method: method, requestData: nil)
    }
}

/// An `VirtaAPIEndpoint` represents Virta REST API endpoints.
final class VirtaAPIEndpoint<RequestData, ResponseData>: APIEndpoint<RequestData, ResponseData>
where ResponseData: Decodable {}

extension APIEndpoint: Equatable where RequestData: Equatable {
    static func == (lhs: APIEndpoint<RequestData, ResponseData>, rhs: APIEndpoint<RequestData, ResponseData>) -> Bool {
        return lhs.method == rhs.method &&
            lhs.path == rhs.path &&
            lhs.requestData == rhs.requestData
    }
}

