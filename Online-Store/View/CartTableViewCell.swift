//
//  CartTableViewCell.swift
//  RD Application
//
//  Created by Георгий Кашин on 18/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    // MARK: - IB Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var amountOfProductLabel: UILabel!
    @IBOutlet weak var amountOfProductStepper: UIStepper!
}

// MARK: - Configuration
extension CartTableViewCell {
    /// Configure cell with cart product at index path
    ///
    /// - Parameters:
    ///   - cartProduct: instance of cart product class
    ///   - indexPath: indexPath of cart product cell
    func configure(with cartProduct: CartProduct, at indexPath: IndexPath) {
        nameLabel.text = cartProduct.product.name
        /// configure color label
        colorLabel.backgroundColor = UIColor(named: cartProduct.product.color)
        colorLabel.layer.borderWidth = 2
        colorLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        colorLabel.layer.cornerRadius = colorLabel.frame.size.width / 2
        colorLabel.clipsToBounds = true
        /// if amountOfProductStepper exists at this cell
        if amountOfProductStepper != nil {
            /// configure stepper
            amountOfProductStepper.tag = indexPath.row
            amountOfProductStepper.value = Double(cartProduct.amount)
            /// configure trash button
            trashButton.tag = indexPath.row
        }
        /// configure amount of product label
        amountOfProductLabel.text = "\(cartProduct.amount)"
        amountOfProductLabel.layer.cornerRadius = 5
        amountOfProductLabel.clipsToBounds = true
        /// configure other
        sizeLabel.text = cartProduct.size
        priceLabel.text = "\(cartProduct.product.price.separatedNumber()) ₽"
        totalLabel.text = "\((cartProduct.product.price * cartProduct.amount).separatedNumber()) ₽"
        /// configure image view
//        guard let imageData = cartProduct.product.imageData.first else { return }
        
        let image = UIImage(named: cartProduct.product.image.first!)!
//        StorageManager.shared.fetchImage(url: cartProduct.product.imageURLs.first!) { image in
//            guard let image = image else { return }
//            DispatchQueue.main.async {
//                self.productImageView.image = image
//            }
//        }
        productImageView.image = image
        
        productImageView.layer.cornerRadius = 5
        productImageView.clipsToBounds = true
    }
}
