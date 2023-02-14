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
                    .frame(width: 90, height: 45)
                    .font(.custom("Karla-Bold", size: 16))
                    .foregroundColor(Color("highlightOne"))
                    .background(Color("primaryOne").cornerRadius(8))
                
                Button("Remove") { }
                    .frame(width: 90, height: 45)
                    .font(.custom("Karla-Bold", size: 16))
                    .foregroundColor(Color("primaryOne"))
                    .border(Color("primaryOne"))
                
                Spacer()
            }
            
            RegistrationForm(isLoggedIn: $isLoggedIn)
            
            // logout button should be placed in this view to logout to on boarding page succesfully
            Button("Log out") {
                UserDefaults.standard.set("", forKey: keyFirstName)
                UserDefaults.standard.set("", forKey: keyLastName)
                UserDefaults.standard.set("", forKey: keyEmail)
                UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
                isLoggedIn = false
                self.presentation.wrappedValue.dismiss() // dismiss from this view to main navigation view
            }
            .frame(maxWidth: .infinity, maxHeight: 45)
            .font(.custom("Karla-Bold", size: 16))
            .foregroundColor(Color("highlightTwo"))
            .background(Color("primaryTwo").cornerRadius(8))
            
            Spacer()
            
        }
        .padding()
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
