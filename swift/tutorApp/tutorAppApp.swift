//
//  tutorAppApp.swift
//  tutorApp
//
//  Created by Samuel Heinz on 2/12/2022.
//

import SwiftUI
import Foundation

@main
struct tutorAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    func callAPI(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else{
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8){
                print(string)
            }
        }
        
        task.resume()
    }
}
