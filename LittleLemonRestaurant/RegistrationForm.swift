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
let keyIsLoggedIn = "keyisloggedin"

struct RegistrationForm: View {    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    @Binding var isLoggedIn: Bool
    @State private var errorMessage = ""
    @State private var showInvalidMessage = false

    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 5) {
                Text("First name")
                    .font(.custom("MarkaziText-Regular", size: 20))
                TextField(isLoggedIn ? (UserDefaults.standard.string(forKey: keyFirstName) ?? "") : "First Name", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("MarkaziText-Regular", size: 22))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Last name").font(.custom("MarkaziText-Regular", size: 20))
                TextField(isLoggedIn ? (UserDefaults.standard.string(forKey: keyLastName) ?? "") : "Last Name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("MarkaziText-Regular", size: 22))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Email").font(.custom("MarkaziText-Regular", size: 20))
                TextField(isLoggedIn ? (UserDefaults.standard.string(forKey: keyEmail) ?? "") : "Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            
            if !isLoggedIn {
                Button("Register") {
                    checkRegistrationForm()
                }
                    .frame(width: 150, height: 40)
                    .font(.custom("MarkaziText-Regular", size: 22))
                    .foregroundColor(Color("highlightOne"))
                    .background(Color("primaryOne").cornerRadius(8))
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
        // if the textfields have valid values, then proceed
        
        UserDefaults.standard.set(firstName, forKey: keyFirstName)
        UserDefaults.standard.set(lastName, forKey: keyLastName)
        UserDefaults.standard.set(email, forKey: keyEmail)
        UserDefaults.standard.set(true, forKey: keyIsLoggedIn)
        isLoggedIn = true
        //print(firstName)
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
