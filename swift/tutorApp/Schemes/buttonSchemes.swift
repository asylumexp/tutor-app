//
//  buttonSchemes.swift
//  tutorApp
//
//  Created by Samuel Heinz on 11/12/2022.
//

import SwiftUI
struct buttonSchemes: View {
    @State private var temp = "signInView"
    @State private var email = "signInView"
    @State private var password = "signInView"

    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    print("MyNewPrimitiveButton triggered. Is it printed ?")
                }){ Text("bing chilling ").padding() }
                    .buttonStyle(MyLoginButton(color: .yellow, parentChange: self.$temp, email: $email, password: $password))
            }
        }
    }
}

struct MyNewPrimitiveButtonStyle: PrimitiveButtonStyle {
    var color: Color
    var parentChange: Binding<String>
    
    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(parentVar: parentChange, configuration: configuration, color: color)
    }
    
    struct MyButton: View {
        @State private var pressed = false
        let parentVar: Binding<String>
        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color
        
        var body: some View {
            
            return configuration.label
                .foregroundColor(.white)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(self.pressed ? 0.5 : 1.0)
                .scaleEffect(self.pressed ? 0.8 : 1.0)
                .onLongPressGesture(minimumDuration: 2.5, maximumDistance: .infinity, pressing: { pressing in
                    withAnimation(.easeInOut(duration: 0.25)) {
                        self.pressed = pressing
                    }
                    if pressing {
                        print("My long pressed starts")
                    } else {
                        print("My long pressed ends")
                        updateView(variable: parentVar)
//                        POST(inputURL: "http://localhost:9000/users/signup")
                    }
                }, perform: { })
        }
    }
}

struct MyLoginButton: PrimitiveButtonStyle {
    var color: Color
    var parentChange: Binding<String>
    var email: Binding<String>
    var password: Binding<String>
    
    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(parentVar: parentChange, configuration: configuration, color: color, email: email, password: password)
    }
    
    struct MyButton: View {
        @State private var pressed = false
        let parentVar: Binding<String>
        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color
        var email: Binding<String>
        var password: Binding<String>
        
        var body: some View {
            
            return configuration.label
                .foregroundColor(.white)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(self.pressed ? 0.5 : 1.0)
                .scaleEffect(self.pressed ? 0.8 : 1.0)
                .onLongPressGesture(minimumDuration: 2.5, maximumDistance: .infinity, pressing: { pressing in
                    withAnimation(.easeInOut(duration: 0.25)) {
                        self.pressed = pressing
                    }
                    if pressing {
                        print("My long pressed starts")
                        signIn(email: email, password: password)
                    } else {
                        print("My long pressed ends")
                        updateView(variable: parentVar)
//                        POST(inputURL: "http://localhost:9000/users/signup")
                    }
                }, perform: { })
        }
    }
}

struct MySignupButton: PrimitiveButtonStyle {
    var color: Color
    var name: Binding<String>
    var parentChange: Binding<String>
    var email: Binding<String>
    var password: Binding<String>
    var signedUp: Bool
    var signingIn: Bool
    var signingUp: Bool
    
    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(parentVar: parentChange, configuration: configuration, color: color, email: email, password: password, signedUp: signedUp, signingIn: signingIn, signingUp: signingUp, name: name)
    }
    
    struct MyButton: View {
        @State private var pressed = false
        let parentVar: Binding<String>
        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color
        var email: Binding<String>
        var password: Binding<String>
        var signedUp: Bool
        var signingIn: Bool
        var signingUp: Bool
        var name: Binding<String>
        
        var body: some View {
            
            return configuration.label
                .foregroundColor(.white)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(self.pressed ? 0.5 : 1.0)
                .scaleEffect(self.pressed ? 0.8 : 1.0)
                .onLongPressGesture(minimumDuration: 2.5, maximumDistance: .infinity, pressing: { pressing in
                    withAnimation(.easeInOut(duration: 0.25)) {
                        self.pressed = pressing
                    }
                    if pressing {
                    } else {
                        if signedUp {
                            signUp(name: name, email: email, password: password, parentVar: parentVar)
                        } else if signingUp {
                            parentVar.wrappedValue = "signUpView"
                        } else if signingIn{
                            parentVar.wrappedValue = "signInView"
                        }
                        
//                        POST(inputURL: "http://localhost:9000/users/signup")
                    }
                }, perform: { })
        }
    }
}
struct buttonSchemes_Previews: PreviewProvider {
    static var previews: some View {
        buttonSchemes()
    }
}
