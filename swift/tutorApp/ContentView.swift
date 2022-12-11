//
//  ContentView.swift
//  tutorApp
//
//  Created by Samuel Heinz on 2/12/2022.
//  Reviewed by Willima Coggins on 11/12/2022.
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
 
struct MyNewPrimitiveButtonStyle: PrimitiveButtonStyle {
    var color: Color

    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }
   
    struct MyButton: View {
        @State private var pressed = false

        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color

        var body: some View {

            return configuration.label
                .foregroundColor(.white)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(self.pressed ? 0.5 : 1.0)
                .scaleEffect(self.pressed ? 0.8 : 1.0)
                .onLongPressGesture(minimumDuration: 2.5, maximumDistance: .infinity, pressing: { pressing in
                withAnimation(.easeInOut(duration: 0.25)) {
                    self.pressed = pressing
                }
                if pressing {
                    print("My long pressed starts")
                    print("     I can initiate any action on start")
                } else {
                    print("My long pressed ends")
                    callAPI()
                }
            }, perform: { })
        }
    }
}

func callAPI(){
    guard let url = URL(string: "http://localhost:9000/users") else{return}
        
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        
        let decoder = JSONDecoder()
        
        if let data = data{
            do{
                let tasks = try decoder.decode([userArray].self, from: data)
                tasks.forEach{ i in
                    print(i.createdAt)
                }
            }catch{
                print(error)
                }
            }
        }
        task.resume()
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

