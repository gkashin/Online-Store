//
//  CategoryTableViewCell.swift
//  RD Application
//
//  Created by Георгий Кашин on 08/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - IB Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}

// MARK: - Configuration
extension CategoryTableViewCell {
    /// Configure cell
    ///
    /// - Parameters:
    ///   - image: cell image
    ///   - title: cell title
    func configure(with image: UIImage, titled title: String) {
        titleLabel.textColor = .white
        titleLabel.text = title
        backgroundImageView.image = image
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.cornerRadius = 5
    }
}
