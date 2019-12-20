//
//  Profile.swift
//  RD Application
//
//  Created by Георгий Кашин on 09/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import Foundation

@objcMembers class Profile: NSObject {
    
    // MARK: - Stored Properties
    var name: String
    var surname: String
    var patronymic: String
    var email: String
    var phoneNumber: String
    var country: String
    var region: String
    var city: String
    var street: String
    var houseNumber: String
    var flatNumber: String
    var zipCode: String
    
    // MARK: - Computed Properties
    var keys: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    var values: [Any] {
        return Mirror(reflecting: self).children.map { $0.value }
    }
    
    var formattedAddress: String {
        return "\(country), \(city),\n\(street) \(houseNumber), \(flatNumber)"
    }
    
    // MARK: - Initializers
    init(
        name: String = "",
        surname: String = "",
        patronymic: String = "",
        email: String = "",
        phoneNumber: String = "",
        street: String = "",
        houseNumber: String = "",
        flatNumber: String = "",
        city: String = "",
        region: String = "",
        country: String = "",
        zipCode: String = ""
    ) {
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.email = email
        self.phoneNumber = phoneNumber
        self.street = street
        self.houseNumber = houseNumber
        self.flatNumber = flatNumber
        self.city = city
        self.region = region
        self.country = country
        self.zipCode = zipCode
    }
}

// MARK: - Methods
extension Profile {
    override func copy() -> Any {
        let newProfile = Profile(name: name, surname: surname, patronymic: patronymic, email: email, phoneNumber: phoneNumber, street: street, houseNumber: houseNumber, flatNumber: flatNumber, city: city, region: region, country: country, zipCode: zipCode)
        return newProfile
    }
}
