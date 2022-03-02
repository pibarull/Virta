//
//  LoginViewModel.swift
//  Virta
//
//  Created by Ilia Ershov on 01.03.2022.
//

import Foundation

final class LoginViewModel {

    weak var vc: LoginViewController?
    var token: String = ""

    lazy var virtaAPIClientService = VirtaAPIClientService()

    func sendAuthRequest(email: String, password: String, completion: @escaping () -> Void) {
        let requestParameters = AuthModelParameters(email: email, code: password)
        let request = virtaAPIClientService.request(VirtaAPI.setAuthData(requestParameters))

        request?.validate().responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                do {
                    let authResponse = try JSONDecoder().decode(AuthModel.self, from: response.data!)
                    self.token = authResponse.token

                    UserDefaults.standard.set(self.token, forKey: "token")
                    UserDefaults.standard.set(true, forKey: "logged_in")

                    completion()
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
