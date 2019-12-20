//
//  ImagePageControl.swift
//  RD Application
//
//  Created by Георгий Кашин on 13/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class ImagePageControl: UIPageControl {

    // MARK: - Initializers
    init(numberOfPages: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.numberOfPages = numberOfPages
        self.hidesForSinglePage = true
        self.isEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
