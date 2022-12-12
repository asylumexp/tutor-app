//
//  ContentView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 2/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var testingView = true
    
    var body: some View {
        if testingView {
            buttonView(parentVar: $testingView)
        } else {
            signInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
