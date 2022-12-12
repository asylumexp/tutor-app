//
//  buttonView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 12/12/2022.
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

struct buttonView: View {
    private var parentVar: Binding<Bool>
    
    init(parentVar: Binding<Bool>) {
        self.parentVar = parentVar
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.init(hex: "071B33"), .init(hex: "833F46"), .init(hex: "FFB123")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(edges: .all)
            VStack {
                Button(action: {
                    print("MyNewPrimitiveButton triggered. Is it printed ?")
                }){ Text("amazing app print text fr emoji").padding() }
                    .buttonStyle(MyNewPrimitiveButtonStyle(color: .yellow, parentChange: self.parentVar))
                
            }
        }
    }
}

