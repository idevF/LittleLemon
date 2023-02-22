//
//  UserForm.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 22.02.2023.
//

import SwiftUI

struct UserForm {
    var firstName: String
    var lastName: String
    var email: String
    
    var errorMessage: String
    var showInvalidMessage: Bool
    var isUserFormValid: Bool
    
    init(firstName: String = "", lastName: String = "", email: String = "", errorMessage: String = "", showInvalidMessage: Bool = false, isUserFormValid: Bool = false) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.errorMessage = errorMessage
        self.showInvalidMessage = showInvalidMessage
        self.isUserFormValid = isUserFormValid
    }
    
    mutating func validateUserForm() {
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
        // save the user information
        UserDefaults.standard.set(firstName, forKey: keyFirstName)
        UserDefaults.standard.set(lastName, forKey: keyLastName)
        UserDefaults.standard.set(email, forKey: keyEmail)
        
        isUserFormValid = true
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


