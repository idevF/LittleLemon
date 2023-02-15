//
//  MenuBreakdown.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 12.02.2023.
//

import SwiftUI

struct MenuBreakdown: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("ORDER FOR DELIVERY!")
                .font(.custom("Karla-ExtraBold", size: 20))
                .foregroundColor(Color("highlightTwo"))
                  
            HStack {
                Button("Starters") { }
                Button("Mains") { }
                Button("Desserts") { }
                Button("Drinks") { }
            }
            .font(.custom("Karla-ExtraBold", size: 16))
            .foregroundColor(Color("primaryOne"))
            .tint(Color("highlightTwo"))
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 12))

            Divider()
        }
        .padding(.horizontal, 30)
    }
}

struct MenuBreakdown_Previews: PreviewProvider {
    static var previews: some View {
        MenuBreakdown()
    }
}
