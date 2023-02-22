//
//  RegistrationForm.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 13.02.2023.
//

import SwiftUI



struct RegistrationForm: View {
    @Environment(\.presentationMode) var presentation
    
    @Binding var isLoggedIn: Bool
    
    @State private var userForm = UserForm()
    

    var body: some View {
        VStack(spacing: 20) {
            
            styledTextFieldSection
            
            registerButton
            
        }
        .alert("ERROR !", isPresented: $userForm.showInvalidMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(userForm.errorMessage)
        }
        .onDisappear {
            userForm.firstName = ""
//            userForm.lastName = ""
//            userForm.email = ""
        }
    }
    
    // styled textfields
    @ViewBuilder
    private var styledTextFieldSection: some View {
        TextField("First Name", text: $userForm.firstName)
            .styledTextField(with: "First Name")
        
        TextField("Last Name", text: $userForm.lastName)
            .styledTextField(with: "Last Name")
        
        TextField("Email", text: $userForm.email)
            .styledTextField(with: "Email")
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocapitalization(.none)
    }
    
    // register button
    private var registerButton: some View {
        Button("Register") {
            userForm.validateUserForm()
            if userForm.isUserFormValid {
                UserDefaults.standard.set(true, forKey: keyIsLoggedIn)
                isLoggedIn = true
                userForm.isUserFormValid = false
            }
        }
        .buttonStyleOne()
    }
}

struct RegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationForm(isLoggedIn: .constant(false))
    }
}
