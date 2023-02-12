//
//  Hero.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 11.02.2023.
//

import SwiftUI

struct Hero: View {
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
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.custom("Karla-Medium", size: 18))
                    .foregroundColor(Color("highlightOne"))
//                    .multilineTextAlignment(.leading)
                    .frame(width: 230, height: 150)
                
                Image("Hero image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Text("")
            Text("")
//            Spacer()
//            Spacer()
//            Spacer()
        }
        .padding()
        .background(Color("primaryOne"))
    }
}


struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
    }
}
