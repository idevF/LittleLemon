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
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Header()
            Text("Personal Information")
                .font(.custom("MarkaziText-Regular", size: 30))
                .foregroundColor(Color("highlightTwo"))
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Avatar")
                        .font(.custom("MarkaziText-Regular", size: 20))
                        .foregroundColor(Color.gray)
                    Image("profile-image-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                
                Button("Change") { }
                    .frame(width: 100, height: 40)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .foregroundColor(Color("highlightOne"))
                    .background(Color("primaryOne").cornerRadius(8))
                
                Button("Remove") { }
                    .frame(width: 100, height: 40)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .foregroundColor(Color("primaryOne"))
                    .border(Color("primaryOne"))
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("First name").font(.custom("MarkaziText-Regular", size: 20))
                TextField(userFirstName, text: $firstName)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("MarkaziText-Regular", size: 22))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Last name").font(.custom("MarkaziText-Regular", size: 20))
                TextField(userLastName, text: $lastName)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("MarkaziText-Regular", size: 22))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Email").font(.custom("MarkaziText-Regular", size: 20))
                TextField(userEmail, text: $email)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .font(.custom("MarkaziText-Regular", size: 22))
            .foregroundColor(Color("highlightTwo"))
            .background(Color("primaryTwo").cornerRadius(8))
            
            HStack(spacing: 30) {
                Spacer()
                Button("Discard changes") { }
                    .frame(width: 150, height: 40)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .foregroundColor(Color("primaryOne"))
                    .background(Color("highlightOne").cornerRadius(8))
                    
                Button("Save changes") { }
                    .frame(width: 150, height: 40)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .foregroundColor(Color("highlightOne"))
                    .background(Color("primaryOne").cornerRadius(8))
                Spacer()
                    
            }
            
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
