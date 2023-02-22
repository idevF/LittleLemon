//
//  Onboarding.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 9.02.2023.
//

let keyFirstName = "firstnamekey"
let keyLastName = "lastnamekey"
let keyEmail = "emailkey"
let keyIsLoggedIn = "isloggedinkey"
let keyNotificationStates = "notificationstateskey"

import SwiftUI

struct Onboarding: View {
    @State private var isLoggedIn = false
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Image("littleLemon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 45)
                
                Hero(searchText: $searchText)
                
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                RegistrationForm(isLoggedIn: $isLoggedIn)
                
                Spacer()
            }
            .padding()
            .onAppear {
                if UserDefaults.standard.bool(forKey: keyIsLoggedIn) {
                    isLoggedIn = true
                }
            }
            
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
