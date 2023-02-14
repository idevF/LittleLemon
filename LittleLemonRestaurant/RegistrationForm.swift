//
//  RegistrationForm.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 13.02.2023.
//

import SwiftUI

let keyFirstName = "firstnamekey"
let keyLastName = "lastnamekey"
let keyEmail = "emailkey"
let keyIsLoggedIn = "isloggedinkey"

struct RegistrationForm: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    @Binding var isLoggedIn: Bool
    @State private var errorMessage = ""
    @State private var showInvalidMessage = false
    
    @State private var isSaved = false
    
    @State private var firstNameLabel = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
    @State private var lastNameLabel = UserDefaults.standard.string(forKey: keyLastName) ?? ""
    @State private var emailLabel = UserDefaults.standard.string(forKey: keyEmail) ?? ""
    
    var body: some View {
        VStack(spacing: 30) {
            // Textfield blocks
            VStack(alignment: .leading, spacing: 5) {
                Text("First name")
                    .font(.custom("MarkaziText-Regular", size: 20))
                TextField(isLoggedIn ? firstNameLabel : "First Name", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("MarkaziText-Regular", size: 22))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Last name").font(.custom("MarkaziText-Regular", size: 20))
                TextField(isLoggedIn ? lastNameLabel : "Last Name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("MarkaziText-Regular", size: 22))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Email").font(.custom("MarkaziText-Regular", size: 20))
                TextField(isLoggedIn ? emailLabel : "Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }

            if UserDefaults.standard.bool(forKey: keyIsLoggedIn) == false {
                // Register button
                Button("Register") {
                    checkRegistrationForm()
                    if isLoggedIn {
                        UserDefaults.standard.set(firstName, forKey: keyFirstName)
                        UserDefaults.standard.set(lastName, forKey: keyLastName)
                        UserDefaults.standard.set(email, forKey: keyEmail)
                        UserDefaults.standard.set(true, forKey: keyIsLoggedIn)
                        isSaved = false
                        self.presentation.wrappedValue.dismiss()
                    }
//                    print(isLoggedIn)
//                    print(UserDefaults.standard.bool(forKey: keyIsLoggedIn))
                }
                .frame(width: 150, height: 40)
                .font(.custom("MarkaziText-Regular", size: 22))
                .foregroundColor(Color("highlightOne"))
                .background(Color("primaryOne").cornerRadius(8))
            }
            
            if UserDefaults.standard.bool(forKey: keyIsLoggedIn) == true {
                HStack(spacing: 30) {
                    Spacer()
                    // Discard button
                    Button("Discard changes") {
                        isSaved = false
                        firstName = firstNameLabel
                        lastName = lastNameLabel
                        email = emailLabel
                    }
                    .frame(width: 150, height: 40)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .foregroundColor(Color("primaryOne"))
                    .background(Color("highlightOne").cornerRadius(8))

                    // Save button
                    Button("Save changes") {
                        checkRegistrationForm()
                        if isSaved {
                            UserDefaults.standard.set(firstName, forKey: keyFirstName)
                            UserDefaults.standard.set(lastName, forKey: keyLastName)
                            UserDefaults.standard.set(email, forKey: keyEmail)
                        }
                    }
                    .frame(width: 150, height: 40)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .foregroundColor(Color("highlightOne"))
                    .background(Color("primaryOne").cornerRadius(8))
                    .alert("NOTIFY !", isPresented: $isSaved) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Personal Information has changed.")
                    }
                    
                    Spacer()
                }
            }
            
        }
        .alert("ERROR !", isPresented: $showInvalidMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(self.errorMessage)
        }
    }
    
    private func checkRegistrationForm() {
        // the textfields have valid values or not
        guard isValid(name: firstName) && isValid(name: lastName) && isValid(email: email)
        else {
            var invalidFirstNameMessage = ""
            if firstName.isEmpty || !isValid(name: firstName) {
                invalidFirstNameMessage = "First Name can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidLastNameMessage = ""
            if lastName.isEmpty || !isValid(name: lastName) {
                invalidLastNameMessage = "Last Name can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidEmailMessage = ""
            if email.isEmpty || !isValid(email: email) {
                invalidEmailMessage = "The e-mail is invalid and cannot be blank."
            }
            
            self.errorMessage = "Found these errors in the form:\n\n \(invalidFirstNameMessage)\(invalidLastNameMessage)\(invalidEmailMessage)"
            
            showInvalidMessage.toggle()
            return
        }

        isLoggedIn = true
        //print(firstName)
        isSaved = true
//        self.presentation.wrappedValue.dismiss()
    }
    
    private func isValid(name: String) -> Bool {
        guard !name.isEmpty, name.count > 2 else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    private func isValid(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

struct RegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationForm(isLoggedIn: .constant(false))
    }
}
