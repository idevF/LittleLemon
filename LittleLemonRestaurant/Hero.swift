//
//  Hero.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 11.02.2023.
//

import SwiftUI

struct Hero: View {
    @Environment(\.presentationMode) var presentation // required for to disable searchbox after logout
    
    @Binding var searchText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Little Lemon")
                .font(.custom("MarkaziText-Medium", size: 64))
                .foregroundColor(Color("primaryTwo"))
                .frame(width: 300, height: 50, alignment: .leading)

            Text("Chicago")
                .font(.custom("MarkaziText-Regular", size: 40))
                .foregroundColor(Color("highlightOne"))
                .frame(width: 300, height: 5, alignment: .leading)

            
            HStack(spacing: 20) {
                Text("""
                    We are a family owned
                    Mediterranean restaurant,
                    focused on traditional
                    recipes served with a
                    modern twist.
                    """)
                    .font(.custom("Karla-Medium", size: 18))
                    .foregroundColor(Color("highlightOne"))
                    .frame(width: 225, height: 120)
                
                Image("Hero image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            if UserDefaults.standard.bool(forKey: keyIsLoggedIn) == true {
                TextField("Search menu", text: $searchText)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding()
        .background(Color("primaryOne"))
    }
}


struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero(searchText: Binding.constant(""))
    }
}
