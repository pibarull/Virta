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

    let headerLabel = UILabel()
    let image = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }

    private func setUpView() {
        view.addSubview(headerLabel)
        view.addSubview(image)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
