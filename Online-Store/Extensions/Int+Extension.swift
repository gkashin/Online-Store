//
//  Int+Extension.swift
//  RD Application
//
//  Created by Георгий Кашин on 06/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import Foundation

extension Int {
    /// Return number separated by ranks
    ///
    /// - Returns: string representation of number separated by ranks
    func separatedNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: self as NSNumber) ?? String(self)
    }
}
