//
//  OfficeTableViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 08/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class OfficeTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    static var profile = Profile()
    static var isLogged = Bool()
    
    // MARK: - IB Outlets
    @IBOutlet var labelCollection: [UILabel]!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
}

// MARK: - IB Actions
extension OfficeTableViewController {
    @IBAction func logoutButtonPressed() {
        OfficeTableViewController.isLogged = false
        /// perform transition to MainViewController
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - UI
extension OfficeTableViewController {
    /// update profile labels text with information from profile properties
    func updateProfileLabels() {
        for (index, label) in labelCollection.enumerated() {
            label.text = OfficeTableViewController.profile.values[index] as? String
        }
    }
}

// MARK: - UITableViewDelegate
extension OfficeTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Navigation
extension OfficeTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toEditingSegue" else { return }
        let destination = segue.destination as! EditingViewController
        /// pass copy of profile property to EditingViewController
        destination.profile = OfficeTableViewController.profile.copy() as! Profile
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "toOfficeSegue" else { return }
        let source = segue.source as! EditingViewController
        OfficeTableViewController.profile = source.profile
        /// update profile labels text with information from profile property
        updateProfileLabels()
        tableView.reloadData()
    }
}
