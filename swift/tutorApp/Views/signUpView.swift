//
//  signInView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 12/12/2022.
//

import SwiftUI

struct signUpView: View {
    @State var parentVar: Binding<String>
    @State var name = ""
    @State var email = ""
    @State var password = ""
    init(parentVar: Binding<String>) {
        self.parentVar = parentVar
    }
    var body: some View {
        HStack {
            
            ZStack {
                // Creates gradient
                LinearGradient(gradient: Gradient(colors: [.init(hex: "071B33"), .init(hex: "833F46"), .init(hex: "FFB123")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea(edges: .all)
                // Email textfield
                Image("Image")
                    .offset(y:-280)
                TextField("Name", text: $name)
                    .padding(.horizontal, 50.0)
                    .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "person.fill")))
                    .offset(y:-140)
                    .textInputAutocapitalization(.never)
                    .frame(maxWidth: 650)
                TextField("Email", text: $email)
                    .padding(.horizontal, 50.0)
                    .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "pencil.line")))
                    .offset(y:-40)
                    .textInputAutocapitalization(.never)
                    .frame(maxWidth: 650)
                    .autocorrectionDisabled()
                // Password securefield
                SecureField("Password", text: $password)
                    .padding(.horizontal, 50.0)
                    .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "lock.fill")))
                    .offset(y:60)
                    .frame(maxWidth: 650)
                // Button
                VStack {
                    Button(action: {
                        print("MyNewPrimitiveButton triggered. Is it printed ?")
                    }){ Text("Sign Up").padding() }
                        .buttonStyle(MySignupButton(color: Color(hex: "040F16"), name: $name, parentChange: parentVar, email: $email, password: $password, signedUp: true, signingIn: false, signingUp: false))
                        .offset(y:180)
                    Button(action: {
                        print("MyNewPrimitiveButton triggered. Is it printed ?")
                    }){ Text("Already registered?").padding() }
                        .buttonStyle(MySignupButton(color: Color(hex: "040F16"), name: $name, parentChange: parentVar, email: $email, password: $password, signedUp: false, signingIn: true, signingUp: false))
                        .offset(y:240)
                    
                }
            }
        }
    }
}

struct signUpView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}


