//
//  Order.swift
//  RD Application
//
//  Created by Георгий Кашин on 12/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import Foundation

class Order {
    
    // MARK: - Stored Properties
    let date = Date()
    let deliveryDate = Date()
    let status = Status.processing
    let productsPrice = CartViewController.total
    var number = Int()
    var products = [CartProduct]()
    var address = String()
    var payment = String()
    var deliveryPrice = Int()
    
    // MARK: - Initializers
    init(products: [CartProduct], address: String, payment: String, deliveryPrice: Int) {
        self.products = products
        self.address = address
        self.payment = payment
        self.deliveryPrice = deliveryPrice
        /// increment order number
        number = OrdersTableViewController.orders.count + 1
    }
}

// MARK: - Computed Properties
extension Order {
    /// title of order
    var title: String {
        return "№ \(number) от \(formattedDate)"
    }
    /// formatted order date
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    /// formatted delivery date
    var formattedDeliveryDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: deliveryDate)
    }
}
