//
//  UIView+Extension.swift
//  RD Application
//
//  Created by Георгий Кашин on 11/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

extension UIView {
    enum Side {
        case top, bottom, left, right
    }
    
    /// Add border to view
    ///
    /// - Parameters:
    ///   - side: side of view to add border
    ///   - color: color of border
    ///   - thickness: thickness of border
    func addBorder(to side: Side, with color: CGColor, thickness: CGFloat) {
        let border = CALayer()
        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: thickness)
        case.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.size.height)
        case .right:
            border.frame = CGRect(x: frame.size.width, y: 0, width: thickness, height: frame.size.height)
        }
        border.backgroundColor = color
        layer.addSublayer(border)
    }
}
