//
//  MenuItem.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    let explanation: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case price = "price"
        case explanation = "description"
        case category = "category"
    }
}
