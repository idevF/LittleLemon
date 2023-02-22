//
//  MenuList.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//

import Foundation

struct MenuList: Decodable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}
