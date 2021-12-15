//
//  ContentView.swift
//  Edvora
//
//  Created by Jameson Hurst on 12/13/21.
//

//1. The given UI must be implemented using SwiftUI
//2. The inputs fields should not be empty
//3. Validations for email (must be a valid email) - done
//4. Validations for password (should have 8 characters, 1 number, 1 upper case alphabet, 1 lower case alphabet)- Done
//5. Validations for username (should not have spaces and no upper case alphabet) - Done
//6. The app must be responsive for all devices (iPhone SE, iPhone 13, iPad)

import SwiftUI


// Custom styling for text entry fields
struct EdvoraTextEntry: ViewModifier {
    var isFocused: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width: 300, height: 60)
            .background(.edvoraTextBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: 1)
                    .foregroundColor(isFocused ? .edvoraMaroonSecondary : .edvoraGreySecondary)
            )
            .padding(.vertical, 10)
    }
}

struct ContentView: View {
    @State private var userName = ""
    @State private var password = ""
    @State private var emailAddress = ""
    
    @FocusState private var userNameIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool
    @FocusState private var emailAddressIsFocused: Bool
    
    let lowercaseLetters = CharacterSet.lowercaseLetters
    let uppercaseLetters = CharacterSet.uppercaseLetters
    
    
    // Text field validation
    var isUserNameValid: Bool {
        if userName.contains(" ") || userName.lowercased() != userName {
            return false
        }
        return true
    }
    
    var isPasswordValid: Bool {
        if password.count < 8 || containsNumbers(str: password).count == 0 || password.rangeOfCharacter(from: uppercaseLetters) == nil || password.rangeOfCharacter(from: lowercaseLetters) == nil {
            return false
        }
        return true
    }
    
    // Email validation using a regular expression: https://www.advancedswift.com/regular-expressions/#email-regular-expression
    
    var isEmailValid: Bool {
        // One or more characters followed by an "@",
        // then one or more characters followed by a ".",
        // and finishing with one or more characters
        let emailPattern = #"^\S+@\S+\.\S+$"#
        
        // Matching Examples
        // user@domain.com
        // firstname.lastname-work@domain.com
        
        // "test@test.com" matches emailPattern,
        // so result is a Range<String.Index>
        let result = emailAddress.range(
            of: emailPattern,
            options: .regularExpression
        )
        
        let isValidEmail = (result != nil)
        return isValidEmail
    }
    
    
    // Validate if entire form is valid
    var isFormValid: Bool {
        if userName.isReallyEmpty || password.isReallyEmpty || emailAddress.isReallyEmpty || !isUserNameValid || !isPasswordValid || !isEmailValid {
            return false
        }
        return true
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                // Logo image
                Image("edvora")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                // Username text entry field
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.edvoraSymbols)
                        .padding()
                    TextField("Username", text: $userName)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .focused($userNameIsFocused)
                .modifier(EdvoraTextEntry(isFocused: userNameIsFocused))
                
                // Password text entry field
                HStack {
                    Image(systemName: "key.fill")
                        .foregroundColor(.edvoraSymbols)
                        .padding()
                    
                    SecureInputView("Password", text: $password, isFocused: passwordIsFocused)
                        .padding(.trailing)
                }
                .focused($passwordIsFocused)
                .modifier(EdvoraTextEntry(isFocused: passwordIsFocused))
                
                // Email address text entry field
                HStack {
                    Text("@")
                        .foregroundColor(.edvoraSymbols)
                        .bold()
                        .padding()
                    TextField("Email address", text: $emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .focused($emailAddressIsFocused)
                .modifier(EdvoraTextEntry(isFocused: emailAddressIsFocused))
                
                // Reset password link
                NavigationLink {
                    Text("Reset your password here.")
                } label: {
                    Text("Forgotten password?")
                        .foregroundColor(.edvoraMaroonSecondary)
                }
                .frame(width: 300, alignment: .trailing)
                
                Spacer()
                
                // Login button
                NavigationLink {
                    Text("Welcome!")
                } label: {
                    Text("LOGIN")
                        .frame(width: 300, height: 60)
                        .background(isFormValid ? .edvoraMaroon : .edvoraSymbols)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.white)
                        .font(.title2.bold())
                }
                .disabled(!isFormValid)
                .padding(.top, 40)
                .padding(.bottom, 20)
                
                Spacer()
                
                // Sign up section
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.secondary)
                    
                    NavigationLink {
                        Text("Sign up for a new account.")
                    } label: {
                        Text("Sign up")
                            .foregroundColor(.edvoraMaroonSecondary)
                            .bold()
                    }
                }
                
            }
            .preferredColorScheme(.light)
        }
        
    }
    
    func containsNumbers(str: String) -> [Character] {
        return str.filter { ("0"..."9").contains($0)}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
