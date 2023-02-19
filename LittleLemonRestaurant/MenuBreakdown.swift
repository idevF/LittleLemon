//
//  MenuBreakdown.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 12.02.2023.
//

import SwiftUI

struct MenuBreakdown: View {
    
    @Binding var categoryName: String
    @Binding var menuSectionSelection: Bool
    
    private let menuSectionNames = ["starters", "mains", "desserts", "drinks"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("ORDER FOR DELIVERY!")
                .font(.custom("Karla-ExtraBold", size: 20))
                .foregroundColor(Color("highlightTwo"))
            
            HStack(spacing: 5) {
                Button("Menu") {
                    categoryName = ""
                    menuSectionSelection = false
                }
                .frame(maxWidth: 80, maxHeight: 30)
                .background(Color("highlightOne").cornerRadius(8))
                
                ForEach(menuSectionNames, id: \.self) { name in
                    Button(name.capitalized) {
                        categoryName = name
                        menuSectionSelection = true
                    }
                    .frame(maxWidth: 80, maxHeight: 30)
                    .background(Color("highlightOne").cornerRadius(8))
                }
            }
            .font(.custom("Karla-Bold", size: 16))
            .foregroundColor(Color("primaryOne"))
            
            Divider()
        }
        .padding(.horizontal, 10)
    }
}

struct MenuBreakdown_Previews: PreviewProvider {
    static var previews: some View {
        MenuBreakdown(categoryName: .constant("main"), menuSectionSelection: .constant(false))
    }
}
