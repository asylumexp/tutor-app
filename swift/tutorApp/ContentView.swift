//
//  ContentView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 2/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var temp = "signInView"
    
    var body: some View {
        if (temp == "signInView") {
            signInView(parentVar: $temp)
        } else if (temp == "buttonView") {
            buttonView(parentVar: $temp)
        } else if (temp == "signUpView") {
            signUpView(parentVar: $temp)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
