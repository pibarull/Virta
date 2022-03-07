//
//  InitialViewController.swift
//  Virta
//
//  Created by Ilia Ershov on 28.02.2022.
//

import UIKit

final class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        // TODO: Implement secure storage of data with KeyChain
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")

        presentFirstViewController(isLoggedIn: isLoggedIn)
    }

    private func presentFirstViewController(isLoggedIn: Bool) {
        if !isLoggedIn {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        } else {
            let vc = StationsTableViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

