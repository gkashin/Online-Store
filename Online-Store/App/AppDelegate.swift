//
//  AppDelegate.swift
//  RD Application
//
//  Created by Георгий Кашин on 03/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /// perform transition to MainViewController
    func transiteToMainViewController() {
        let tabBarController = window?.rootViewController as? UITabBarController
        tabBarController?.selectedIndex = 0
        let navigationController = tabBarController?.selectedViewController as? UINavigationController
        navigationController?.popToRootViewController(animated: true)
    }
}
