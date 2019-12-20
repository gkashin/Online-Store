//
//  OrderDetailViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 13/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {

    // MARK: - Stored Properties
    var order: Order!
    
    // MARK: - IB Outlets
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var productsView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var deliveryDateView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var productsPriceLabel: UILabel!
    @IBOutlet weak var deliveryPriceLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
    }
}

// MARK: - UI
extension OrderDetailViewController {
    /// setup user interface
    func setupUI() {
        title = order.title
        /// customize interface elements
        customizeInterfaceElements()
        /// update labels text with order information
        updateLabels()
    }
    
    /// customize interface elements
    func customizeInterfaceElements() {
        deliveryDateView.addBorder(to: .bottom, with: #colorLiteral(red: 0.8235294118, green: 0.8549019608, blue: 0.9019607843, alpha: 1), thickness: 1)
    }
    
    /// update labels text with order information
    func updateLabels() {
        addressLabel.text = order.address
        paymentLabel.text = order.payment
        productsPriceLabel.text = "\(order.productsPrice.separatedNumber()) ₽"
        deliveryPriceLabel.text = "\(order.deliveryPrice.separatedNumber()) ₽"
        deliveryDateLabel.text = order.formattedDeliveryDate
        totalLabel.text = "Оплачено: \((order.productsPrice + order.deliveryPrice).separatedNumber()) ₽"
    }
}

// MARK: - UITableViewDataSource
extension OrderDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        /// configure cell with product at index path
        let product = order.products[indexPath.row]
        cell.configure(with: product, at: indexPath)
        return cell
    }
}

// MARK: - Navigation
extension OrderDetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toProductDetailSegue" else { return }
        guard let destination = segue.destination as? ProductDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        /// pass selected product information to ProductDetailViewController
        let cartProduct = order.products[indexPath.row]
        destination.product = cartProduct.product
        destination.sizeButtonsStackView.selectedSize = cartProduct.size
    }
}
