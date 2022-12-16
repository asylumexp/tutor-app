//
//  signInView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 12/12/2022.
//

import SwiftUI

struct signInView: View {
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
                Image(systemName: "person.2.gobackward")
                    .offset(y:-280)
                    .font(.system(size: 60))
                    .colorInvert()
                TextField("Email", text: $email)
                    .padding(.horizontal, 50.0)
                    .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "pencil.line")))
                    .offset(y:-140)
                    .textInputAutocapitalization(.never)
                // Password securefield
                SecureField("Password", text: $password)
                    .padding(.horizontal, 50.0)
                    .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "lock.fill")))
                    .offset(y:-20)
                // Button
                VStack {
                    Button(action: {
                        print("MyNewPrimitiveButton triggered. Is it printed ?")
                    }){ Text("Sign In").padding() }
                        .buttonStyle(MyLoginButton(color: Color(hex: "040F16"), parentChange: parentVar, email: $email, password: $password))
                        .offset(y:100)
                    Button(action: {
                        print("MyNewPrimitiveButton triggered. Is it printed ?")
                    }){ Text("Not registered?").padding() }
                        .buttonStyle(MySignupButton(color: Color(hex: "040F16"), name: $name, parentChange: parentVar, email: $email, password: $password, signedUp: false, signingIn: false, signingUp: true))
                        .offset(y:240)
                    
                }
            }
        }
    }
}

struct signInView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


