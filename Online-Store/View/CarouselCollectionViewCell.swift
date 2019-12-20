//
//  CarouselCollectionViewCell.swift
//  RD Application
//
//  Created by Георгий Кашин on 04/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Stored Properties
    static let reuseIdentifier = "CarouselCollectionViewCell"
    let imageView = UIImageView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        /// add image view within cell
        addImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Appearance
extension CarouselCollectionViewCell {
    /// add image view within cell
    func addImageView() {
        addSubview(imageView)
        /// configure image view
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        /// constrain image view within cell
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
