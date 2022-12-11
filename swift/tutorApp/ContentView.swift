//
//  ContentView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 2/12/2022.
//

import SwiftUI

struct userArray:Codable {
    let _id: String
    let name: String
    let email: String
    let password: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
}

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(edges: .all)
            VStack {
                Button(action: {
                    print("MyNewPrimitiveButton triggered. Is it printed ?")
                }){ Text("bing chilling ").padding() }
                    .buttonStyle(MyNewPrimitiveButtonStyle(color: .yellow))
                
            }
        }
    }
}



