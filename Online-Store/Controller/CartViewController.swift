//
//  CartViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 18/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: - Stored Properties    
    static var total = 0
    static var cartProductList = [CartProduct]()
    
    // MARK: - IB Outlets
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomInfoView: UIView!
    @IBOutlet weak var stubStackView: UIStackView!
}

// MARK: - IB Actions
extension CartViewController {    
    @IBAction func trashButtonPressed(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        /// delete row at index path
        deleteRow(at: indexPath)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        /// update user interface using index path
        updateUI(using: indexPath)
    }
    
    @IBAction func toShoppingButtonPressed() {
        /// perform transition to MainViewController
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.transiteToMainViewController()
    }
}

// MARK: - UIViewController Methods
extension CartViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
        /// add observer to remove all products from the cart, reload data at table view and update badge and total label
        NotificationCenter.default.addObserver(self, selector: #selector(removeAll), name: NSNotification.Name(rawValue: "CartViewController.removeAll"), object: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// add observer to update the tab bar icon badge
        NotificationCenter.default.addObserver(self, selector: #selector(updateBadge), name: NSNotification.Name(rawValue: "updateBadge"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let isEmpty = CartViewController.cartProductList.isEmpty
        /// enable or disable stub depending on if cart is empty
        updateStub(isOn: isEmpty)
        
        guard !isEmpty else { return }
        /// update total label text
        updateTotalLabel()
        tableView.reloadData()
    }
}

// MARK: - UI
extension CartViewController {
    /// setup user interface
    func setupUI() {
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
        /// hide back bar button title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// Update user interface when stepper value changed using index path
    ///
    /// - Parameter indexPath: index path of selected cell
    func updateUI(using indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CartTableViewCell
        let stepperValue = Int(cell.amountOfProductStepper.value)
        let productPrice = CartViewController.cartProductList[indexPath.row].product.price
        let oldAmountOfProduct = CartViewController.cartProductList[indexPath.row].amount
        
        /// update stored properties based on new stepper value
        if stepperValue > oldAmountOfProduct {
            CartViewController.total += productPrice
            CartViewController.cartProductList[indexPath.row].amount += 1
        } else {
            CartViewController.total -= productPrice
            CartViewController.cartProductList[indexPath.row].amount -= 1
        }
    
        /// update cell information
        cell.amountOfProductLabel.text = String(stepperValue)
        cell.totalLabel.text = "\((stepperValue * productPrice).separatedNumber()) ₽"
        
        /// update total label text
        updateTotalLabel()
        /// update badge for tab bar icon
        updateBadge()
    }
    
    /// Update stub depending on isOn value
    ///
    /// - Parameter isOn: boolean value indicating enable stub or not
    func updateStub(isOn: Bool) {
        stubStackView.isHidden = !isOn
        bottomInfoView.isHidden = isOn
    }
    
    /// Delete row at index path
    ///
    /// - Parameter indexPath: index path of deleted cell
    func deleteRow(at indexPath: IndexPath) {
        let productPrice = CartViewController.cartProductList[indexPath.row].product.price
        let amountOfProduct = CartViewController.cartProductList[indexPath.row].amount
        
        /// decrease total value by total cost of the product
        CartViewController.total -= productPrice * amountOfProduct
        /// remove product from cart product list
        CartViewController.cartProductList.remove(at: indexPath.row)
        
        tableView.reloadData()
        
        /// update total label text
        updateTotalLabel()
        /// update badge for tab bar icon
        updateBadge()
        
        /// enable stub if cart is empty
        if CartViewController.cartProductList.isEmpty {
            updateStub(isOn: true)
        }
    }
    
    /// update total label text
    func updateTotalLabel() {
        totalLabel.text = "ИТОГО: \(CartViewController.total.separatedNumber()) ₽"
    }
    
    /// update badge for tab bar icon
    @objc func updateBadge() {
        /// calculate the total amount of products in the cart
        let amountOfProducts = CartViewController.cartProductList.reduce(0) { $0 + $1.amount }
        /// update badge value
        navigationController?.tabBarItem.badgeValue = (amountOfProducts == 0) ? nil : String(amountOfProducts)
    }
    
    /// remove all products from the cart, reload data at table view and update badge and total label
    @objc func removeAll() {
        /// remove all products from the cart
        CartViewController.cartProductList.removeAll()
        tableView.reloadData()
        /// update badge for tab bar icon
        updateBadge()
        /// update total label text
        CartViewController.total = 0
        updateTotalLabel()
    }
}

// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartViewController.cartProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        /// configure cell with cart product at index path
        let cartProduct = CartViewController.cartProductList[indexPath.row]
        cell.configure(with: cartProduct, at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        /// delete row at index path
        deleteRow(at: indexPath)
    }
}

// MARK: - Navigation
extension CartViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toProductDetailSegue" else { return }
        guard let destination = segue.destination as? ProductDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        /// pass selected product information to ProductDetailViewController
        let cartProduct = CartViewController.cartProductList[indexPath.row]
        destination.product = cartProduct.product
        destination.sizeButtonsStackView.selectedSize = cartProduct.size
    }
}
