//
//  MenuBreakdown.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 12.02.2023.
//

import SwiftUI

struct MenuBreakdown: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("ORDER FOR DELIVERY!")
                .font(.custom("Karla-Bold", size: 28))
                .foregroundColor(Color("highlightTwo"))
                  
            HStack {
                Button("Starters") { }
                Button("Mains") { }
                Button("Desserts") { }
                Button("Drinks") { }
            }
            .font(.custom("MarkaziText-Regular", size: 22))
            .foregroundColor(Color("primaryOne"))
            .tint(Color("highlightTwo"))
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 15))
        }
    }
}

struct MenuBreakdown_Previews: PreviewProvider {
    static var previews: some View {
        MenuBreakdown()
    }
}
