//
//  UserProfile.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation // required to dismiss from this view to main navigation view
    
    @State private var isLoggedIn = true
    
    var body: some View {
        VStack(spacing: 30) {
            
            Header()
            
            avatarSection
            
            RegistrationForm(isLoggedIn: $isLoggedIn)
            
            logoutButton
        }
        .padding()
    }
    // avatar layer
    private var avatarSection: some View {
        VStack {
            Text("Personal Information")
                .font(.custom("Karla-Bold", size: 20))
                .foregroundColor(Color("highlightTwo"))
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Avatar")
                        .font(.custom("Karla-Regular", size: 16))
                        .foregroundColor(Color.gray)
                    Image("profile-image-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                // avatar buttons
                Button("Change") { }
                    .buttonStyleThree()
                
                Button("Remove") { }
                    .buttonStyleFour()
                
                Spacer()
            }
        }
    }
    // logout button
    private var logoutButton: some View {
        Button("Log out") {
            UserDefaults.standard.set("", forKey: keyFirstName)
            UserDefaults.standard.set("", forKey: keyLastName)
            UserDefaults.standard.set("", forKey: keyEmail)
            
            UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
            isLoggedIn = false
            self.presentation.wrappedValue.dismiss() // dismiss from this view to main navigation view
        }
        .buttonStyleFive()
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
