//
//  textBoxSchemes.swift
//  tutorApp
//
//  Created by Samuel Heinz on 14/12/2022.
//

import Foundation
import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    
    @State var icon: Image?
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if icon != nil {
                icon
                    .foregroundColor(Color(UIColor.systemGray4))
            }
            configuration
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color(UIColor.systemGray4), lineWidth: 2)
        }
        .background(RoundedRectangle(cornerRadius: 5).fill(.white).opacity(0.25))
    }
}
