//
//  buttonSchemes.swift
//  tutorApp
//
//  Created by Samuel Heinz on 11/12/2022.
//

import SwiftUI
struct buttonSchemes: View {
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    print("MyNewPrimitiveButton triggered. Is it printed ?")
                }){ Text("bing chilling ").padding() }
                    .buttonStyle(MyNewPrimitiveButtonStyle(color: .yellow))
            }
        }
    }
}

struct MyNewPrimitiveButtonStyle: PrimitiveButtonStyle {
    var color: Color
    
    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }
    
    struct MyButton: View {
        @State private var pressed = false
        
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
                        FETCH(inputURL: "http://localhost:9000/users", Parse: true)
                    } else {
                        print("My long pressed ends")
//                        POST(inputURL: "http://localhost:9000/users")
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
