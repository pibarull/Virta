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

    private var loginViewModel = LoginViewModel()
    private var loginView: LoginView?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.vc = self

        self.loginView = LoginView(viewModel: loginViewModel)
        setUpView()
        setUpLayout()
    }

    private func setUpView() {
        view.addSubview(loginView!)
    }

    private func setUpLayout() {
        loginView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
