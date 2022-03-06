//
//  LoginView.swift
//  Virta
//
//  Created by Ilia Ershov on 01.03.2022.
//

import Foundation
import SnapKit
import UIKit

private enum Constants {

    static let headerLabelText = "Log In and Charge!"
}

final class LoginView: UIView {

    private let headerLabel = UILabel()
    private let imageView = UIImageView(frame: .init(x: .zero, y: .zero, width: 150, height: 150))
    private let usernameTextField = LoginTextField()
        .setPlaceholder(with: "Username")
        .setImage(with: (.init(named: "usernameIcon") ?? .init()))
    private let passwordTextField = LoginTextField()
        .setPlaceholder(with: "Password")
        .setImage(with: .init(named: "passwordIcon")!)
    private let textFieldsStackView = UIStackView()
    private let logInButton = UIButton()

    private var loginViewModel: LoginViewModel?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(viewModel: LoginViewModel) {
        super.init(frame: .zero)
        self.loginViewModel = viewModel

        setUpView()
        setUpImageView()
        setUpStackView()
        setUpHeaderLabel()
        setUpLabelButton()
        setUpLayout()
    }

    private func setUpView() {
        backgroundColor = .white
        addSubview(headerLabel)
        addSubview(imageView)
        addSubview(textFieldsStackView)
        textFieldsStackView.addArrangedSubview(usernameTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        addSubview(logInButton)

        usernameTextField.setTextFieldDelegate(with: self)
        passwordTextField.setTextFieldDelegate(with: self)

        passwordTextField.getTextField().isSecureTextEntry = true
    }

    private func setUpHeaderLabel() {
        headerLabel.text = Constants.headerLabelText
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }

    private func setUpStackView() {
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = 30
    }

    private func setUpImageView() {
        imageView.image = UIImage(named: "logIn")
    }

    private func setUpLabelButton() {
        logInButton.backgroundColor = .yellow
        logInButton.layer.cornerRadius = 4
        logInButton.layer.shadowColor = UIColor.lightGray.cgColor
        logInButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        logInButton.layer.shadowOpacity = 1.0
        logInButton.layer.shadowRadius = 0.0
        logInButton.layer.masksToBounds = false

        logInButton.setTitleColor(.black, for: .normal)
        logInButton.setTitle("Log In", for: .normal)

        logInButton.addTarget(superview, action: #selector(logInButtonPressed), for: .touchUpInside)
    }

    @objc func logInButtonPressed() {
        usernameTextField.getTextField().resignFirstResponder()
        passwordTextField.getTextField().resignFirstResponder()
        loginViewModel?.sendAuthRequest(email: usernameTextField.getTextField().text ?? "",
                                        password: passwordTextField.getTextField().text ?? "") {
            let vc = StationsTableViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            let topVC = UIApplication.topViewController()
            topVC?.present(nav, animated: true)
        }
    }

    private func setUpLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageView.snp.top).offset(-20)
        }

        imageView.snp.makeConstraints { make in
            make.size.equalTo(150)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(textFieldsStackView.snp.top).offset(-20)
        }

        textFieldsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(logInButton.snp.top).offset(-40)
        }

        logInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
}

extension LoginView: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField.getTextField() {
            guard let text = textField.text else { return }
            if text.isEmpty {
                usernameTextField.setSeparatorColor(with: .systemRed)
            } else {
                usernameTextField.setSeparatorColor(with: .lightGray)
            }
        }

        if textField == passwordTextField.getTextField() {
            guard let text = textField.text else { return }
            if text.isEmpty {
                passwordTextField.setSeparatorColor(with: .systemRed)
            } else {
                passwordTextField.setSeparatorColor(with: .lightGray)
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField.getTextField() {
            passwordTextField.becomeFirstResponder()
        }

        if textField == passwordTextField.getTextField() {
            logInButtonPressed()
        }

        return true
    }
}
