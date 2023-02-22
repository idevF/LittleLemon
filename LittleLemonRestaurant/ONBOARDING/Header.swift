//
//  Header.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 11.02.2023.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack(alignment: .center, spacing: 55) {
            Spacer()
            Image("littleLemon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 45)
            
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .clipShape(Circle())
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
