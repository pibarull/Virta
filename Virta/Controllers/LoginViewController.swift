//
//  LoginViewController.swift
//  Virta
//
//  Created by Ilia Ershov on 28.02.2022.
//

import Foundation
import SnapKit
import UIKit

final class LoginViewController: UIViewController {

    let loginView = LoginView()

    lazy var virtaAPIClientService = VirtaAPIClientService()

    override func viewDidLoad() {
        super.viewDidLoad()
        sendAuthRequest(email: "", password: "")
        setUpView()
        setUpLayout()
    }

    private func sendAuthRequest(email: String, password: String) {
        let requestParameters = AuthModelParameters(email: "candidate1@virta.global", code: "1Candidate!")
        let request = virtaAPIClientService.request(VirtaAPI.setAuthData(requestParameters))

        request?.validate().responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                do {
                    let authResponse = try JSONDecoder().decode(AuthModel.self, from: response.data!)
                    print(authResponse)
                    print(authResponse.token)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }

    private func setUpView() {
        view.addSubview(loginView)
    }

    private func setUpLayout() {
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
