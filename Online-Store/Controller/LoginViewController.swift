//
//  LoginViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 16/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IB Actions
    @IBAction func exitBarButtonPressed() {
        /// perform transition to MainViewController
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarController
        tabBarController?.selectedIndex = 0
        dismiss(animated: true)
    }
    
    @IBAction func loginButtonPressed() {
        OfficeTableViewController.isLogged = true
        /// perform transition to OfficeViewController
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarController
        tabBarController?.selectedIndex = 3
        dismiss(animated: true)
    }
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
    }
}

// MARK: - UI
extension LoginViewController {
    /// setup user interface
    func setupUI() {
        /// make navigation bar transparent
        setupNavigationBar()
    }
    
    /// make navigation bar transparent
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = .clear
    }
}
