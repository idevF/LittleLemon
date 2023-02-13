//
//  UserProfile.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//

import SwiftUI

struct UserProfile: View {
//    @Environment(\.presentationMode) var presentation
//    
//    private let userFirstName = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
//    private let userLastName = UserDefaults.standard.string(forKey: keyLastName) ?? ""
//    private let userEmail = UserDefaults.standard.string(forKey: keyEmail) ?? ""
    @State private var isLoggedIn = true
    
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
                // avatar buttons
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
            
            RegistrationForm(isLoggedIn: $isLoggedIn)
            
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
