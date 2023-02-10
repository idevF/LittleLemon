//
//  Onboarding.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 9.02.2023.
//

import SwiftUI

let keyFirstName = "firstnamekey"
let keyLastName = "lastnamekey"
let keyEmail = "emailkey"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    @State private var isLoggedIn = false
    @State private var errorMessage = ""
    @State private var showInvalidMessage = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Button("Register") {
                    checkRegisterForm()
                }
            }
            .alert("ERROR !", isPresented: $showInvalidMessage) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(self.errorMessage)
            }
        }
    }
    
    private func checkRegisterForm() {
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
        isLoggedIn = true
        //print(firstName)
    }
    
    func isValid(name: String) -> Bool {
        guard !name.isEmpty, name.count > 2 else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    func isValid(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
