//
//  signInView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 12/12/2022.
//

import SwiftUI

struct signInView: View {
    @State var parentVar: Binding<String>
    @State var email = ""
    @State var password = ""
    init(parentVar: Binding<String>) {
        self.parentVar = parentVar
    }
    var body: some View {
        HStack {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.init(hex: "071B33"), .init(hex: "833F46"), .init(hex: "FFB123")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea(edges: .all)
                TextField("Email", text: $email)
                    .padding(.horizontal, 50.0)
                    .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "pencil.line")))
                    .offset(y:-240)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
                    .padding(.horizontal, 50.0)
                    .textFieldStyle(OutlinedTextFieldStyle(icon: Image(systemName: "lock")))
                    .offset(y:-120)
                VStack {
                    Button(action: {
                        print("MyNewPrimitiveButton triggered. Is it printed ?")
                    }){ Text("amazing app").padding() }
                        .buttonStyle(MyLoginButton(color: .yellow, parentChange: parentVar, email: $email, password: $password))
                    
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


