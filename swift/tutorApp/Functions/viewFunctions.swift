//
//  viewFunctions.swift
//  tutorApp
//
//  Created by Samuel Heinz on 12/12/2022.
//

import Foundation
import SwiftUI

func updateView(variable: Binding<String>) {
    if (variable.wrappedValue == "buttonView") {
        variable.wrappedValue = "signInView"
    } else {
        variable.wrappedValue = "buttonView"
    }
}
