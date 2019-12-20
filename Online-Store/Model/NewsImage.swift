//
//  NewsImage.swift
//  RD Application
//
//  Created by Георгий Кашин on 04/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

enum NewsImage: String, CaseIterable {
    case backpack = "newsBackpack"
    case sportBag = "newsSportBag"
    case hoodie = "newsHoodie"
}

extension NewsImage {
    /// Create images with NewsImage enum names
    ///
    /// - Returns: array of news images
    static func fetchImages() -> [UIImage] {
        var arrayOfImages = [UIImage]()
        
        for imageCase in NewsImage.allCases {
            let imageName = imageCase.rawValue
            guard let image = UIImage(named: imageName) else { continue }
            arrayOfImages.append(image)
        }
        return arrayOfImages
    }
}
