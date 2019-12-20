//
//  CheckoutViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 11/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: - Stored Properties
    /// temporary property
    let deliveryPrice = 350
    
    // MARK: - Computed Properties
    static var orderProfile: Profile {
        let profile = OfficeTableViewController.profile.copy() as! Profile
        return profile
    }
    
    // MARK: - IB Outlets
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet weak var productsView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var productsPriceLabel: UILabel!
    @IBOutlet weak var deliveryPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
}

// MARK: - IB Actions
extension CheckoutViewController {
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        /// set value to profile for key depending on text field
        let textFieldIndex = textFieldCollection.firstIndex(of: sender)!
        let key = CheckoutViewController.orderProfile.keys[textFieldIndex]
        let text = sender.text ?? ""
        CheckoutViewController.orderProfile.setValue(text, forKey: key)
    }
    
    @IBAction func paymentButtonPressed() {
        /// add order to orders list
        let address = CheckoutViewController.orderProfile.formattedAddress
        let order = Order(products: CartViewController.cartProductList, address: address, payment: "payment", deliveryPrice: deliveryPrice)
        OrdersTableViewController.orders.insert(order, at: 0)
        /// post notification to remove all products from the cart, reload data at table view and update badge and total label of CartViewController
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CartViewController.removeAll"), object: nil)
        /// perform transition to MainViewController
        navigationController?.popToRootViewController(animated: true)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.transiteToMainViewController()
    }
}

// MARK: - UIViewController Methods
extension CheckoutViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        /// update user interface
        updateUI()
    }
}

// MARK: - UI
extension CheckoutViewController {
    /// setup user interface
    func setupUI() {
        /// update text fields text with current profile properties
        updateTextFields()
        /// setup appearance of interface elements
        setupInterfaceElements()
    }
    
    /// update user interface
    func updateUI() {
        /// update price labels text
        updatePriceLabels()
        /// update payment button text
        updatePaymentButton()
    }
    
    /// setup appearance of interface elements
    func setupInterfaceElements() {
        /// setup payment button
        paymentButton.layer.cornerRadius = 8
        paymentButton.clipsToBounds = true
        /// setup views
        productsView.addBorder(to: .bottom, with: #colorLiteral(red: 0.8235294118, green: 0.8549019608, blue: 0.9019607843, alpha: 1), thickness: 1)
        deliveryView.addBorder(to: .bottom, with: #colorLiteral(red: 0.8235294118, green: 0.8549019608, blue: 0.9019607843, alpha: 1), thickness: 1)
    }
    
    /// update text fields text with current profile properties
    func updateTextFields() {
        for (index, textField) in textFieldCollection.enumerated() {
            textField.text = CheckoutViewController.orderProfile.values[index] as? String
        }
    }
    
    /// update price labels text
    func updatePriceLabels() {
        productsPriceLabel.text = "\(CartViewController.total.separatedNumber()) ₽"
        deliveryPriceLabel.text = "\(deliveryPrice.separatedNumber()) ₽"
        totalPriceLabel.text = "\((CartViewController.total + deliveryPrice).separatedNumber()) ₽"
    }
    
    /// update payment button text
    func updatePaymentButton() {
        paymentButton.setTitle("К оплате " + totalPriceLabel.text!, for: .normal)
    }
}
