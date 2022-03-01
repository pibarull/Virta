//
//  LoginTextField.swift
//  Virta
//
//  Created by Ilia Ershov on 28.02.2022.
//

import Foundation
import UIKit

private enum Constants {

    // Put all constants here
}

class LoginTextField: UIView {

    private let textField = UITextField()
    private let imageView = UIImageView()
    private let separatorView = UIView()

    init() {
        super.init(frame: .zero)

        setUpView()
        setUpTextField()
        setUpSeparator()
        setIpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(textField)
        addSubview(imageView)
        addSubview(separatorView)
    }

    private func setUpTextField() {
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
    }

    private func setUpImageView() {
        imageView.image = .init()
    }

    private func setUpSeparator() {
        separatorView.backgroundColor = .lightGray
    }

    private func setIpLayout() {
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.left.equalToSuperview()
        }

        textField.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.right.equalToSuperview()
        }

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

    func getTextField() -> UITextField {
        return textField
    }

    func setPlaceholder(with text: String) -> LoginTextField {
        textField.placeholder = text
        return self
    }

    func setImage(with image: UIImage) -> LoginTextField {
        imageView.image = image
        return self
    }

    func setTextFieldDelegate(with responsible: Any) {
        textField.delegate = responsible as? UITextFieldDelegate
    }

    func setSeparatorColor(with color: UIColor) {
        separatorView.backgroundColor = color
    }
}
