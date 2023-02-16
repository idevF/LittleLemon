//
//  RegistrationForm.swift
//  LittleLemonRestaurant
//
//  Created by idevF on 13.02.2023.
//

import SwiftUI

struct RegistrationForm: View {
//    @Environment(\.presentationMode) var presentation

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""

    @Binding var isLoggedIn: Bool
    
    @State private var isChecked = false
    @State private var isSaved = false
    @State private var errorMessage = ""
    @State private var showInvalidMessage = false

    @State private var firstNameLabel = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
    @State private var lastNameLabel = UserDefaults.standard.string(forKey: keyLastName) ?? ""
    @State private var emailLabel = UserDefaults.standard.string(forKey: keyEmail) ?? ""
    
    @State private var orderCheckmark = false
    @State private var passwordCheckmark = false
    @State private var specialCheckmark = false
    @State private var newsCheckmark = false

    var body: some View {
        VStack(spacing: 20) {
            // Textfield blocks
            VStack(alignment: .leading, spacing: 5) {
                Text("First name")
                    .font(.custom("Karla-Regular", size: 16))
                    .foregroundColor(Color.gray)
                TextField(isLoggedIn ? firstNameLabel : "First Name", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("Karla-Bold", size: 16))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Last name")
                    .font(.custom("Karla-Regular", size: 16))
                    .foregroundColor(Color.gray)
                TextField(isLoggedIn ? lastNameLabel : "Last Name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("Karla-Bold", size: 16))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Email")
                    .font(.custom("Karla-Regular", size: 16))
                    .foregroundColor(Color.gray)
                TextField(isLoggedIn ? emailLabel : "Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .font(.custom("Karla-Bold", size: 16))
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            
            if !isLoggedIn {
                Button("Register") {
                    checkRegistrationForm()
                    if isChecked {
                        UserDefaults.standard.set(true, forKey: keyIsLoggedIn)
                        isLoggedIn = true
                        isChecked = false
                    }
                }
                .frame(width: 160, height: 40)
                .font(.custom("Karla-Bold", size: 16))
                .foregroundColor(Color("highlightOne"))
                .background(Color("primaryOne").cornerRadius(8))
            }
            
            if isLoggedIn {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Email notifications")
                        .font(.custom("Karla-Bold", size: 18))
                        .foregroundColor(Color("highlightTwo"))
                    
                    HStack {
                        Image(systemName: orderCheckmark ? "checkmark.square.fill" : "square")
                            .foregroundColor(orderCheckmark ? Color("primaryOne") : Color.black)
                        Text("Order statutes")
                    }
                    .onTapGesture {
                        orderCheckmark.toggle()
                    }
                    
                    HStack {
                        Image(systemName: passwordCheckmark ? "checkmark.square.fill" : "square")
                            .foregroundColor(passwordCheckmark ? Color("primaryOne") : Color.black)
                        Text("Password changes")
                    }
                    .onTapGesture {
                        passwordCheckmark.toggle()
                    }
                    
                    HStack {
                        Image(systemName: specialCheckmark ? "checkmark.square.fill" : "square")
                            .foregroundColor(specialCheckmark ? Color("primaryOne") : Color.black)
                        Text("Special offers")
                    }
                    .onTapGesture {
                    specialCheckmark.toggle()
                    }
                    
                    HStack {
                        Image(systemName: newsCheckmark ? "checkmark.square.fill" : "square")
                            .foregroundColor(newsCheckmark ? Color("primaryOne") : Color.black)
                        Text("Newsletter")
                    }
                    .onTapGesture {
                        newsCheckmark.toggle()
                    }
                }
                .font(.custom("Karla-Regular", size: 16))
                .padding(.trailing, 220)
                
                HStack(spacing: 30) {
                    Spacer()
                    // Discard button
                    Button("Discard changes") {
                        firstName = ""; lastName = ""; email = ""
                        orderCheckmark = false; passwordCheckmark = false; specialCheckmark = false; newsCheckmark = false
                    }
                    .frame(width: 160, height: 40)
                    .font(.custom("Karla-Bold", size: 16))
                    .foregroundColor(Color("primaryOne"))
                    .background(Color("highlightOne").cornerRadius(8))
                    
                    // Save button
                    Button("Save changes") {
                        checkRegistrationForm()
                        if isChecked {
                            isSaved = true
                            isChecked = false
                        }
                    }
                    .frame(width: 160, height: 40)
                    .font(.custom("Karla-Bold", size: 16))
                    .foregroundColor(Color("highlightOne"))
                    .background(Color("primaryOne").cornerRadius(8))
                    .alert("NOTIFICATION !", isPresented: $isSaved) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Personal information has changed.")
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
        .onDisappear {
            firstName = ""
//            lastName = ""
//            email = ""
            isSaved = false
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
        
        UserDefaults.standard.set(firstName, forKey: keyFirstName)
        UserDefaults.standard.set(lastName, forKey: keyLastName)
        UserDefaults.standard.set(email, forKey: keyEmail)
        
        isChecked = true
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
