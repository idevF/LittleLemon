//
//  Menu.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            
            List {
                
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
