//
//  ProductCollectionViewCell.swift
//  RD Application
//
//  Created by Георгий Кашин on 10/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var toCartButton: UIButton!
}

// MARK: - Configuration
extension ProductCollectionViewCell {
    /// Configure cell
    ///
    /// - Parameters:
    ///   - product: instance of product class
    ///   - indexPath: indexPath of product cell
    func configure(with product: Product, at indexPath: IndexPath) {
        productName.text = product.name
        productPrice.text = "\(product.price.separatedNumber()) ₽"
        layer.cornerRadius = 5
        toCartButton.tag = indexPath.row
        /// setup infoView
        infoView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        infoView.layer.cornerRadius = 5
        /// setup image
//        guard let imageData = product.imageData.first else { return }
        
        let image = UIImage(named: product.image.first!)!
//        StorageManager.shared.fetchImage(url: product.imageURLs.first!) { image in
//            guard let image = image else { return }
//            DispatchQueue.main.async {
//                self.productImage.image = image
//            }
//        }
        
        productImage.image = image
        productImage.contentMode = .scaleAspectFill
    }
}
