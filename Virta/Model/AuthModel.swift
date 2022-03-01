//
//  AuthModel.swift
//  Virta
//
//  Created by Ilia Ershov on 01.03.2022.
//

struct AuthModel {

    var accessToken: String
    var token: String
    var tokenType: String
    var expiresIn: Int
}

extension AuthModel: Decodable {

    enum CodingKeys: String, CodingKey {

        case accessToken = "access_token"
        case token
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}

extension AuthModel: Equatable {}
