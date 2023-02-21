//
//  UtilityViews.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 20.02.2023.
//

import SwiftUI
// TextField style
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
// Button styles
struct StyleOneButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 160, height: 40)
            .font(.custom("Karla-Bold", size: 16))
            .foregroundColor(Color("highlightOne"))
            .background(Color("primaryOne").cornerRadius(8))
    }
}
extension View {
    func buttonStyleOne() -> some View {
        modifier(StyleOneButton())
    }
}

struct StyleTwoButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 160, height: 40)
            .font(.custom("Karla-Bold", size: 16))
            .foregroundColor(Color("primaryOne"))
            .background(Color("highlightOne").cornerRadius(8))
    }
}
extension View {
    func buttonStyleTwo() -> some View {
        modifier(StyleTwoButton())
    }
}

struct StyleThreeButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 90, height: 40)
            .font(.custom("Karla-Bold", size: 16))
            .foregroundColor(Color("highlightOne"))
            .background(Color("primaryOne").cornerRadius(8))
    }
}
extension View {
    func buttonStyleThree() -> some View {
        modifier(StyleThreeButton())
    }
}

struct StyleFourButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 90, height: 40)
            .font(.custom("Karla-Bold", size: 16))
            .foregroundColor(Color("primaryOne"))
            .border(Color("primaryOne"))
    }
}
extension View {
    func buttonStyleFour() -> some View {
        modifier(StyleFourButton())
    }
}

struct StyleFiveButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 40)
            .font(.custom("Karla-Bold", size: 16))
            .foregroundColor(Color("highlightTwo"))
            .background(Color("primaryTwo").cornerRadius(8))
            .overlay( RoundedRectangle(cornerRadius: 8).stroke(Color("secondaryOne"), lineWidth: 2) )
    }
}
extension View {
    func buttonStyleFive() -> some View {
        modifier(StyleFiveButton())
    }
}

struct StyleSixButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 80, maxHeight: 30)
            .background(Color("highlightOne").cornerRadius(8))
    }
}
extension View {
    func buttonStyleSix() -> some View {
        modifier(StyleSixButton())
    }
}
