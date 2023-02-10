//
//  UserProfile.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    private let userFirstName = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
    private let userLastName = UserDefaults.standard.string(forKey: keyLastName) ?? ""
    private let userEmail = UserDefaults.standard.string(forKey: keyEmail) ?? ""
    
    var body: some View {
        VStack {
            Text("Personal Information")
            
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 150, height: 150)
            
            Text(userFirstName)
            Text(userLastName)
            Text(userEmail)
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
