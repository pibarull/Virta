//
//  LoginViewController.swift
//  Virta
//
//  Created by Ilia Ershov on 28.02.2022.
//

import Foundation
import SnapKit
import UIKit

private enum Constants {

    static let headerLabelText = "Log In and Charge!"
}

final class LoginViewController: UIViewController {

    let headerLabel = UILabel()
    let imageView = UIImageView(frame: .init(x: .zero, y: .zero, width: 150, height: 150))
    let usernameTextField = LoginTextField()
        .setPlaceholder(with: "Username")
        .setImage(with: (.init(named: "usernameIcon") ?? .init()))
    let passwordTextField = LoginTextField()
        .setPlaceholder(with: "Password")
        .setImage(with: .init(named: "passwordIcon") ?? .init())
    let textFieldsStackView = UIStackView()

    let logInButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpImageView()
        setUpStackView()
        setUpHeaderLabel()
        setUpLayout()
    }

    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(headerLabel)
        view.addSubview(imageView)
        view.addSubview(textFieldsStackView)
        textFieldsStackView.addArrangedSubview(usernameTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        view.addSubview(logInButton)
    }

    private func setUpHeaderLabel() {
        headerLabel.text = Constants.headerLabelText
    }

    private func setUpStackView() {
        textFieldsStackView.axis = .vertical
    }

    private func setUpImageView() {
        imageView.image = UIImage(named: "logIn")
    }

    private func setUpLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(20)
            make.bottom.equalTo(imageView.snp.top).offset(20)
        }

        imageView.snp.makeConstraints { make in
            make.size.equalTo(150)
            make.centerX.equalToSuperview()
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(20)
            make.bottom.equalTo(textFieldsStackView.snp.top).offset(20)
        }

        textFieldsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(20)
            make.bottom.equalTo(logInButton.snp.top).offset(20)
        }

        logInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
//            make.bottom.equalToSuperview().offset(20)
        }
//        usernameTextField.snp.makeConstraints { make in
//            make.size.equalTo(150)
//            make.centerX.equalToSuperview()
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(20)
//            make.bottom.equalTo(passwordTextField.snp.top).offset(20)
//        }
//
//        passwordTextField.snp.makeConstraints { make in
//            make.size.equalTo(150)
//            make.centerX.equalToSuperview()
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(20)
//            make.bottom.equalTo(passwordTextField.snp.top).offset(20)
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
