//
//  TabBarController.swift
//  RD Application
//
//  Created by Георгий Кашин on 17/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - UITabBarController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard item.tag == 1 else { return }
        if !OfficeTableViewController.isLogged {
            performSegue(withIdentifier: "toLoginSegue", sender: nil)
        }
    }
}
