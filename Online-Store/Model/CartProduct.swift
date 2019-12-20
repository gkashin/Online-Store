//
//  CartProduct.swift
//  RD Application
//
//  Created by Георгий Кашин on 21/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

class CartProduct {
    
    // MARK: - Stored Properties
    var product = Product()
    var size: String?
    var amount = Int()
    
    // MARK: - Initializers
    init(product: Product = Product(), size: String? = nil, amount: Int = 1) {
        self.product = product
        self.size = size
        self.amount = amount
    }
}
