//
//  RegistrationViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 16/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet var textFieldCollection: [UITextField]!
    
    // MARK: - IB Actions
    @IBAction func exitBarButtonPressed() {
        /// perform transition to MainViewController
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarController
        tabBarController?.selectedIndex = 0
        dismiss(animated: true)
    }
    
    @IBAction func registrationButtonPressed() {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textFieldCollection.first?.becomeFirstResponder()
    }
}

// MARK: - UI
extension RegistrationViewController {
    /// setup user interface
    func setupUI() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
}
