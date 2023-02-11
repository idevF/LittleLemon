//
//  Header.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 11.02.2023.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack(alignment: .center, spacing: 50) {
            Spacer()
            Image("Logo")
            
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipped()
        }
        .padding()
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
