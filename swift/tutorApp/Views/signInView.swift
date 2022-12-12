//
//  signInView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 12/12/2022.
//

import SwiftUI

struct signInView: View {
    @State private var state = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.init(hex: "071B33"), .init(hex: "833F46"), .init(hex: "FFB123")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(edges: .all)
            VStack {
                Button(action: {
                    print("MyNewPrimitiveButton triggered. Is it printed ?")
                }){ Text("amazing app").padding() }
                    .buttonStyle(MyNewPrimitiveButtonStyle(color: .yellow, parentChange: $state))
                
            }
        }
    }
}

struct signInView_Previews: PreviewProvider {
    static var previews: some View {
        signInView()
    }
}
