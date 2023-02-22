//
//  UserProfile.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 10.02.2023.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation // required to dismiss from this view to main navigation view
    
    @State private var firstNameLabel = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
    @State private var lastNameLabel = UserDefaults.standard.string(forKey: keyLastName) ?? ""
    @State private var emailLabel = UserDefaults.standard.string(forKey: keyEmail) ?? ""
    
    @State private var isLoggedIn = true
    @State private var isSaved = false
    
    @State private var userForm = UserForm()
    
    private let notificationOptions = ["Order statutes", "Password changes", "Special offers", "Newsletter"]
    @State private var notificationStates = [false, false, false, false]
    
    var body: some View {
        VStack(spacing: 20) {
            
            Header()
            
            avatarSection
            
            styledTextFieldSection
            
            emailNotifications
            
            logoutButton
            
            discardChangesButtonAndSaveChangesButton
        }
        .padding()
        .alert("ERROR !", isPresented: $userForm.showInvalidMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(userForm.errorMessage)
        }
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
    
    // styled textfields
    @ViewBuilder
    private var styledTextFieldSection: some View {
        TextField(firstNameLabel, text: $userForm.firstName)
            .styledTextField(with: "First Name")
        
        TextField(lastNameLabel, text: $userForm.lastName)
            .styledTextField(with: "Last Name")
        
        TextField(emailLabel, text: $userForm.email)
            .styledTextField(with: "Email")
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocapitalization(.none)
    }
    
    // email notifications
    private var emailNotifications: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Email notifications")
                .font(.custom("Karla-Bold", size: 18))
                .foregroundColor(Color("highlightTwo"))
            
            ForEach(notificationOptions.indices, id: \.self) { index in
                HStack {
                    Image(systemName: notificationStates[index] ? "checkmark.square.fill" : "square")
                        .foregroundColor(notificationStates[index] ? Color("primaryOne") : Color.black)
                    Text(notificationOptions[index])
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        notificationStates[index].toggle()
                    }
                }
            }
        }
        .font(.custom("Karla-Regular", size: 16))
        .padding(.trailing, 220)
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
    
    // discard and save buttons
    private var discardChangesButtonAndSaveChangesButton: some View {
        HStack(spacing: 30) {
            Spacer()
            // Discard button
            Button("Discard changes") {
                userForm.firstName = ""; userForm.lastName = ""; userForm.email = ""
                notificationStates = [false, false, false, false]
            }
            .buttonStyleTwo()

            // Save button
            Button("Save changes") {
                userForm.validateUserForm()
                if userForm.isUserFormValid {
                    isSaved = true
                    userForm.isUserFormValid = false
                }
                UserDefaults.standard.set(notificationStates, forKey: keyNotificationStates)
            }
            .buttonStyleOne()
            .alert("NOTIFICATION !", isPresented: $isSaved) {
                Button("OK", role: .cancel) { isSaved = false }
            } message: {
                Text("Personal information has changed.")
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
