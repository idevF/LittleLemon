//
//  MenuItem.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case price = "price"
        case image = "image"
        case category = "category"
    }
}
