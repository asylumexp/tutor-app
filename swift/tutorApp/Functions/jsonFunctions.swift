//
//  functionsJSON.swift
//  tutorApp
//
//  Created by Samuel Heinz on 11/12/2022.
//

import Foundation
import SwiftUI

struct DefaultsKeys {
    static let token = "token"
    static let cookie = "cookie"
}

func POST(inputURL: String) {
    let url = URL(string: inputURL)!
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    
    components.queryItems = [
        URLQueryItem(name: "name", value: "name"),
        URLQueryItem(name: "email", value: "email2"),
        URLQueryItem(name: "password", value: "password")
    ]
    
    let query = components.url!.query
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = Data(query!.utf8)
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let response = response {
            print(response)
        }
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }
    }.resume()
}

func FETCH(inputURL: String, Parse: Bool){
    guard let url = URL(string: inputURL) else{return}
    
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        
        let decoder = JSONDecoder()
        
        if Parse == true {
            if let data = data{
                do{
                    let tasks = try decoder.decode([userArray].self, from: data)
                    tasks.forEach{ i in
                        print(i)
                    }
                }catch{
                    print(error)
                }
            }
        }
    }
    task.resume()
    
}

func signUp() {
    let url = URL(string: "http://localhost:9000/users/signup")!
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    
    components.queryItems = [
        URLQueryItem(name: "name", value: "name"),
        URLQueryItem(name: "email", value: "email"),
        URLQueryItem(name: "password", value: "password")
    ]
    
    let query = components.url!.query
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = Data(query!.utf8)
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        
        if let response = response {
            print(response)
        }
        if let data = data {
            do {
                var response = [:]
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                response = json.unsafelyUnwrapped
                print(response[AnyHashable("success")]!)
                print(response[AnyHashable("token")]!)
            } catch {
                print(error)
            }
        }
    }.resume()
}


func signIn(email: Binding<String>, password: Binding<String>) {
    let url = URL(string: "http://localhost:9000/users/signin")!
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    components.queryItems = [
        URLQueryItem(name: "email", value: email.wrappedValue),
        URLQueryItem(name: "password", value: password.wrappedValue)
    ]
    
    let query = components.url!.query
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = Data(query!.utf8)
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do {
                var response1 = [:]
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                response1 = json.unsafelyUnwrapped
                //                print(response[AnyHashable("token")]!)
                if (response1[AnyHashable("success")]! as! Int == 1) {
                    if let httpResponse = response as? HTTPURLResponse {
                        if let reauthCookie = httpResponse.allHeaderFields["Set-Cookie"] as? String {
                            saveCookie(Cookie: reauthCookie, Token: reauthCookie)
                            
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }.resume()
}

func saveCookie(Cookie: String, Token: String) {
    let defaults = UserDefaults.standard
    defaults.set(Cookie, forKey: DefaultsKeys.cookie)
    defaults.set(Token, forKey: DefaultsKeys.token)
}


