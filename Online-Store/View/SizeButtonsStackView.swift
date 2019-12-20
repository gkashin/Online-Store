//
//  SizeButtonsStackView.swift
//  RD Application
//
//  Created by Георгий Кашин on 14/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class SizeButtonsStackView: UIStackView {
    
    // MARK: - Stored Properties
    var product = Product()
    var selectedSizeButton: UIButton?
    var selectedSize: String?
    let scrollView = UIScrollView()
    
    // MARK: - Initializers
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension SizeButtonsStackView {
    /// Configure size buttons stack view with product
    ///
    /// - Parameter product: selected product
    func configure(withProduct product: Product) {
        self.product = product
        /// configure scroll view
        configureScrollView()
        /// configure stack view
        configureStackView()
        
        /// create and configure buttons for every size
        let sizeRange = Array(product.sizeRange)
        for size in sizeRange {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            /// configure button with size
            configureButton(button, with: size)
            /// add button to stack view
            addArrangedSubview(button)
        }
    }
    
    /// Configure button with size
    ///
    /// - Parameters:
    ///   - button: next button
    ///   - size: size for this button
    func configureButton(_ button: UIButton, with size: String) {
        button.setTitle(size, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        /// setup button depending on if size already selected
        if button.titleLabel?.text == selectedSize {
            button.layer.borderWidth = 2
            selectedSizeButton = button
        } else {
            button.layer.borderWidth = 1
        }
        /// add target for button
        button.addTarget(self, action: #selector(sizeButtonPressed), for: .touchUpInside)
        /// constrain button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    /// configure scroll view
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(self)
    }
    
    /// configure stack view
    func configureStackView() {
        tag = 1
        axis = .horizontal
        distribution = .fillEqually
        spacing = 20
        translatesAutoresizingMaskIntoConstraints = false
        /// constrain stack view
        self.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    }
}

// MARK: - Custom Methods
extension SizeButtonsStackView {
    @objc func sizeButtonPressed(_ sender: UIButton) {
        /// setup button border width
        if selectedSizeButton != sender {
            sender.layer.borderWidth = 2
            selectedSizeButton?.layer.borderWidth = 1
        }
        selectedSizeButton = sender
        /// post notification to productDetailViewController to update cart button
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateToCartButton"), object: nil)

        // perform adding product to cart if it's adding from alert
        guard superview?.superview is SizeSelectionAlert else { return }
        /// add product to cart
        addToCart()
        /// post notification to sizeSelectionAlert to close alert with animation
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "animatedClose"), object: nil)
    }
    
    /// add product to cart
    func addToCart() {
        /// create cart product with product and selected size
        selectedSize = selectedSizeButton?.titleLabel?.text
        let cartProduct = CartProduct(product: product, size: selectedSize)
    
        /// check if there is product with such ID and size in the cart
        let cartProductIndex = CartViewController.cartProductList.firstIndex(where: { (productFromCart) -> Bool in
            productFromCart.product.id == cartProduct.product.id
                && productFromCart.size == cartProduct.size
        })
        
        if let cartProductIndex = cartProductIndex {
            /// increase amount of the product
            CartViewController.cartProductList[cartProductIndex].amount += 1
        } else {
            /// append product to cart product list
            CartViewController.cartProductList.append(cartProduct)
        }
        /// increase total price of the selected product price
        CartViewController.total += cartProduct.product.price
        
        /// post notification to update the tab bar cart icon badge
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateBadge"), object: nil)
    }
}
