//
//  OrdersTableViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 12/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {

    // MARK: - Stored Properties
    static var orders = [Order]()
    
    // MARK: - UIViewController Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension OrdersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrdersTableViewController.orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
        /// configure cell with order
        let order = OrdersTableViewController.orders[indexPath.row]
        cell.configure(with: order)
        return cell
    }
}

// MARK: - Navigation
extension OrdersTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toOrderDetailSegue" else { return }
        guard let destination = segue.destination as? OrderDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        /// pass selected order information to OrderDetailViewController
        destination.order = OrdersTableViewController.orders[indexPath.row]
    }
}
