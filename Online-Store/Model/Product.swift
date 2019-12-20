//
//  Product.swift
//  RD Application
//
//  Created by Георгий Кашин on 10/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

struct Product: Codable {
    var id = Int()
    var name = String()
    var specification = String()
    var price = Int()
//    var imageURLs: [URL]!
    var image = [String]()
    var color = String()
    var category = Int()
    var subcategory = Int()
    var composition = String()
    var sizeRange = [String]()
    var date = Date()
}
