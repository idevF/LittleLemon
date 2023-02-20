//
//  UtilityViews.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 20.02.2023.
//

import SwiftUI

struct RegisteringField: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(text)
                .font(.custom("Karla-Regular", size: 16))
                .foregroundColor(Color.gray)
            
            content
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("Karla-Bold", size: 16))
                .disableAutocorrection(true)
        }
    }
}

extension View {
    func styledTextField(with text: String) -> some View {
        modifier(RegisteringField(text: text))
    }
}
