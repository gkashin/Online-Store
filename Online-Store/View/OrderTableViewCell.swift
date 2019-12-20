//
//  OrderTableViewCell.swift
//  RD Application
//
//  Created by Георгий Кашин on 12/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    // MARK: - IB Outlets
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
}

// MARK: - Configuration
extension OrderTableViewCell {
    /// Configure cell with order
    ///
    /// - Parameter order: instance of order class
    func configure(with order: Order) {
        orderNumberLabel.text = "№ \(order.number)"
        orderDateLabel.text = "от " + order.formattedDate
        orderStatusLabel.text = order.status.rawValue
    }
}
