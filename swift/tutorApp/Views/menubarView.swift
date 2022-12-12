//
//  menubarView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 11/12/2022.
//

import SwiftUI

struct menubarView: View {
    
    var body: some View {
        
        VStack {
            HStack {
                Text("TUTORAPP")
                Text("Tutor APp 3")
            }
            Rectangle()
                .background(Circle().foregroundColor(Color.red))
                .frame(width: 30, height: 20)
                .offset(y: -30)

        }
    }
}

struct menubarView_Previews: PreviewProvider {
    static var previews: some View {
        menubarView()
    }
}
