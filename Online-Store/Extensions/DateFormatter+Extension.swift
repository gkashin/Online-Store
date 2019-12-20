//
//  DateFormatter+Extension.swift
//  RD Application
//
//  Created by Георгий Кашин on 17/08/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
