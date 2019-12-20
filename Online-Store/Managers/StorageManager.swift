//
//  StorageManager.swift
//  RD Application
//
//  Created by Георгий Кашин on 11/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class StorageManager {
    /// Load data from Realm to product list with category
    ///
    /// - Parameters:
    ///   - productList: list of the products
    ///   - category: category of the products
    
    func loadSubcategories(for category: Int) -> [Subcategory] {
        switch category {
        case 1:
            return [
                Subcategory(id: 1, name: "Все товары", image: "allMen", category: 1),
                Subcategory(id: 2, name: "Худи", image: "hoodieMen", category: 1),
                Subcategory(id: 3, name: "Лонгсливы", image: "longsleevesMen", category: 1),
                Subcategory(id: 4, name: "Motivational", image: "motivationalMen", category: 1),
                Subcategory(id: 5, name: "Штаны", image: "pantsMen", category: 1),
                Subcategory(id: 6, name: "Футболки", image: "shirtsMen", category: 1),
                Subcategory(id: 7, name: "Шорты", image: "shortsMen", category: 1),
                Subcategory(id: 8, name: "Майки", image: "singletsMen", category: 1),
            ]
        case 2:
            return [
                Subcategory(id: 9, name: "Все товары", image: "allWomen", category: 2),
                Subcategory(id: 10, name: "Худи", image: "hoodieWomen", category: 2),
                Subcategory(id: 11, name: "Лосины", image: "leggingsWomen", category: 2),
                Subcategory(id: 12, name: "Лонгсливы", image: "longsleevesWomen", category: 2),
                Subcategory(id: 13, name: "Штаны", image: "pantsWomen", category: 2),
                Subcategory(id: 14, name: "Шорты", image: "shortsWomen", category: 2),
                Subcategory(id: 15, name: "Топы", image: "topsWomen", category: 2),
            ]
        case 3:
            return [
                Subcategory(id: 16, name: "Все товары", image: "allAccessories", category: 3),
                Subcategory(id: 17, name: "Рюкзаки и сумки", image: "backpacks", category: 3),
                Subcategory(id: 18, name: "Кепки", image: "caps", category: 3),
                Subcategory(id: 19, name: "Блокнот", image: "notepad", category: 3),
            ]
        default:
            break
        }
        return []
    }
    
    func loadProducts(for category: Int, and subcategory: Int) -> [Product] {
        if category == 0 && subcategory == 0 {
            return [
                Product(id: 1, name: "Худи на молнии", specification: "Road to the Dream Худи на Молнии - новая модель осенней коллекции, максимальный комфорт и неповторимый стиль в холодную пору! Приятная ткань, посадка по фигуре, удобный капюшон - все это, новая худи на молнии от RD!", price: 2600, image: ["hoodie1", "hoodie2", "hoodie3", "hoodie4"], color: "pink", category: 1, subcategory: 2, composition: "Хлопок 95%, лайкра 5%", sizeRange: ["XS", "S", "M", "L", "XL", "XXL"], date: Date()),
                Product(id: 2, name: "Худи без рукавов", specification: "Road to the Dream - Худи без рукавов - стиль, комфорт и функциональность все сочетается в новой худи без рукавов! Идеально подходит для тренировок в зале и в теплую погоду на улице! Приятный, мягкий трикотаж, лого вышивкой, капюшон и ощущение того что тебя не остановить, все это в новой худи без рукавов от Road to the Dream!", price: 1800, image: ["hoodie5", "hoodie6", "hoodie7", "hoodie8"], color: "black", category: 1, subcategory: 2, composition: "Хлопок 90%, эластан 10%", sizeRange: ["XS", "S", "M", "L", "XL", "XXL"], date: Date()),
                Product(id: 3, name: "Спортивный комплект", specification: "Road to the Dream Спортивный комплект - это продолжение женской линии уже в спортивном стиле. Специально разработаны для тренировок. Оптимальны при интенсивных физических нагрузках. Отличные термо-регуляционные свойства.", price: 2625, image: ["sport1", "sport2", "sport3", "sport4"], color: "Color-1", category: 2, subcategory: 3, composition: "Полиамид 97%, эластан 3%", sizeRange: ["XS", "S", "M", "L"], date: Date()),
                Product(id: 4, name: "Лонгслив Crop", specification: "Road to the Dream Лонгслив Кроп - новая модель в коллекции, которая послужит прекрасным дополнением к лосинам. Выгляди и чувствуй себя элегантно и женственно даже во время тяжелой тренировки. ", price: 1700, image: ["longsleeve1", "longsleeve2", "longsleeve3", "longsleeve4"], color: "black", category: 2, subcategory: 4, composition: "Полиэфир 88%, эластан 12%", sizeRange: ["XS", "S", "M", "L"], date: Date()),
                Product(id: 5, name: "Рюкзак", specification: """
                        Лучший рюкзак на каждый день!
                        Армированные нити на швах
                        Репсовое переплетение для дополнительной прочности
                        Один большой вместительный отдел и один маленький отдел для мелочей;
                        Внутренний карман на липучке для ноутбука. Рассчитан для ноутбуков не более 15.6";
                        Усиленная спинка и ручки для комфортной носки;
                        Регулируемая длина ручек;
                        Вертикальное лого Road to the Dream и логотип на ручке;
                        Литраж ~ 25 литров;
                        """,
                        price: 3500, image: ["backpack1", "backpack2", "backpack3", "backpack4"], color: "Color-1", category: 3, subcategory: 2, composition: "Полиэстер (нейлон) 100%", sizeRange: ["M"], date: Date())
                
            ]
        }
        if category == 1 {
            switch subcategory {
            case 2:
                return [
                    Product(id: 1, name: "Худи на молнии", specification: "Road to the Dream Худи на Молнии - новая модель осенней коллекции, максимальный комфорт и неповторимый стиль в холодную пору! Приятная ткань, посадка по фигуре, удобный капюшон - все это, новая худи на молнии от RD!", price: 2600, image: ["hoodie1", "hoodie2", "hoodie3", "hoodie4"], color: "pink", category: 1, subcategory: 2, composition: "Хлопок 95%, лайкра 5%", sizeRange: ["XS", "S", "M", "L", "XL", "XXL"], date: Date()),
                    Product(id: 2, name: "Худи без рукавов", specification: "Road to the Dream - Худи без рукавов - стиль, комфорт и функциональность все сочетается в новой худи без рукавов! Идеально подходит для тренировок в зале и в теплую погоду на улице! Приятный, мягкий трикотаж, лого вышивкой, капюшон и ощущение того что тебя не остановить, все это в новой худи без рукавов от Road to the Dream!", price: 1800, image: ["hoodie5", "hoodie6", "hoodie7", "hoodie8"], color: "black", category: 1, subcategory: 2, composition: "Хлопок 90%, эластан 10%", sizeRange: ["XS", "S", "M", "L", "XL", "XXL"], date: Date())
                ]
            default:
                break
            }
        }
        if category == 2 {
            switch subcategory {
            case 3:
                return [
                Product(id: 3, name: "Спортивный комплект", specification: "Road to the Dream Спортивный комплект - это продолжение женской линии уже в спортивном стиле. Специально разработаны для тренировок. Оптимальны при интенсивных физических нагрузках. Отличные термо-регуляционные свойства.", price: 2625, image: ["sport1", "sport2", "sport3", "sport4"], color: "Color-1", category: 2, subcategory: 3, composition: "Полиамид 97%, эластан 3%", sizeRange: ["XS", "S", "M", "L"], date: Date())
                ]
            case 4:
                return [
                 Product(id: 4, name: "Лонгслив Crop", specification: "Road to the Dream Лонгслив Кроп - новая модель в коллекции, которая послужит прекрасным дополнением к лосинам. Выгляди и чувствуй себя элегантно и женственно даже во время тяжелой тренировки. ", price: 1700, image: ["longsleeve1", "longsleeve2", "longsleeve3", "longsleeve4"], color: "black", category: 2, subcategory: 4, composition: "Полиэфир 88%, эластан 12%", sizeRange: ["XS", "S", "M", "L"], date: Date())
                ]
            default:
                break
            }
        }
        if category == 3 {
            switch subcategory {
            case 2:
                return [
                    Product(id: 5, name: "Рюкзак", specification: """
                        Лучший рюкзак на каждый день!
                        Армированные нити на швах
                        Репсовое переплетение для дополнительной прочности
                        Один большой вместительный отдел и один маленький отдел для мелочей;
                        Внутренний карман на липучке для ноутбука. Рассчитан для ноутбуков не более 15.6";
                        Усиленная спинка и ручки для комфортной носки;
                        Регулируемая длина ручек;
                        Вертикальное лого Road to the Dream и логотип на ручке;
                        Литраж ~ 25 литров;
                        """,
                            price: 3500, image: ["backpack1", "backpack2", "backpack3", "backpack4"], color: "Color-1", category: 3, subcategory: 2, composition: "Полиэстер (нейлон) 100%", sizeRange: ["M"], date: Date())
                ]
            default:
                break
            }
        }
        return []
    }
    
//    static func loadData(to productList: inout [Product], with category: String? = nil) {
//        guard let category = category else {
//            /// create product list with all products
//            productList = Array(realm.objects(Product.self))
//            return
//        }
//        /// create filtered product list with current category
//        productList = realm.objects(Product.self).filter({ (product) -> Bool in
//            return product.category == category
//        })
//    }
    
    // MARK: - Stored Properties
    static var shared = StorageManager()
    let baseURL = URL(string: "http://localhost:8080")!
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Methods
    func fetchSubcategories(for category: Int, completion: @escaping ([Subcategory]?) -> Void) {
        let subcategoryURL = baseURL.appendingPathComponent("subcategories/\(category)")
        let task = URLSession.shared.dataTask(with: subcategoryURL) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
//            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                completion(nil)
//                return
//            }
            //            let subcategories = jsonDictionary["subcategories"] as? [String]
            let jsonDecoder = JSONDecoder()
            let subcategories = try? jsonDecoder.decode([Subcategory].self, from: data)
            completion(subcategories)
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
//        components?.host = baseURL.host
//        guard let imageURL = components?.url else {
//            completion(nil)
//            return
//        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    func fetchProducts(forCategory category: Int? = nil, andSubcategory subcategory: Int? = nil, completion: @escaping ([Product]?) -> Void) {
//        let initialURL = baseURL.appendingPathComponent("men")
//        var components = URLComponents(url: initialURL, resolvingAgainstBaseURL: true)!
//        components.queryItems = [URLQueryItem(name: "category", value: subcategory)]
//        guard let productsURL = components.url else {
//            completion(nil)
//            return
//        }
//        print(productsURL)
        var productURL = baseURL.appendingPathComponent("products")
        if category != nil && subcategory != nil {
            productURL = baseURL.appendingPathComponent("products").appendingPathComponent("\(category!)").appendingPathComponent("\(subcategory!)")
        }
//        let productURL = URL(string: "http://95.217.10.56:5432/categories")!
        let task = URLSession.shared.dataTask(with: productURL) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(.dateFormatter)
            
            guard let products = try? jsonDecoder.decode([Product].self, from: data) else {
                print(#line, #function, "Can't decode data from \(data)")
                completion(nil)
                return
            }
            completion(products)
        }
        task.resume()
    }
}
