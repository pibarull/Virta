//
//  AuthModelParameters.swift
//  Virta
//
//  Created by Ilia Ershov on 01.03.2022.
//

struct AuthModelParameters {

    var email: String
    var code: String
}

extension AuthModelParameters: Encodable {

    enum CodingKeys: String, CodingKey {

        case email
        case code
    }
}

extension AuthModelParameters: Equatable {}
