//
//  ContentView.swift
//  IExoda
//
//  Created by Jared Paubel on 4/28/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//
import SwiftUI
import Foundation


struct ContentView: View {
    let date: Date
    let dateFormatter: DateFormatter
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    //FIXME @State var results = [TaskEntry]()
    
    init() {
        date = Date()
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none // date is turned off
        dateFormatter.timeStyle = .short
    }
    
    var dateValue: String {
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                VStack(alignment: .leading) {
                    Text("IExoda")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(Color.blue)
                    Text(dateValue)
                    .padding(20)
                }
               
                
                Spacer()
                
                
                VStack (alignment: .center) {
                    Text("Do things and you will get things" + "\n" + " - Some wise guy")
                        .padding()
                    
                    Text("How do you feel today?")
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Button(action: {
                            self.alertTitle = "😃"
                            self.alertMessage = "I'm glad you're feeling good!"
                            self.showAlert.toggle()
                        }) {
                            Text("😃")
                        }
                        
                        Button(action: {
                            self.alertTitle = "🙂"
                            self.alertMessage = "I hope you aren't too bad!"
                            self.showAlert.toggle()
                        }) {
                            Text("🙂")
                        }
                        
                        Button(action: {
                            self.alertTitle = "😕"
                            self.alertMessage = "I hope you get better!"
                            self.showAlert.toggle()
                        }) {
                            Text("😕")
                        }
                        
                        Button(action: {
                            self.alertTitle = "😖"
                            self.alertMessage = "Oh no! Please talk to someone!"
                            self.showAlert.toggle()
                        }) {
                            Text("😖")
                        }
                    }
                    .padding(.horizontal)
                    .alert(isPresented: $showAlert) {
                        return Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                
                
                Spacer()
                
                VStack(alignment: .center) {
                    NavigationLink(destination: OrderView()) {
                        Text("To Ledger")
                            .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                            .font(.title)
                    
                    }
                    .padding()
                    
                    NavigationLink(destination: ExpenseView()) {
                        Text("To Expense")
                            .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                            .font(.title)
                    }
                    .padding(.bottom)
                }
            }
        }
//FIXME        func loadAPIdata() {
//            guard let url = URL(string:   "https://zenquotes.io/api/[mode]/[key]?option1=value&option2=value") else {
//                print("Your API end point is invalid")
//                return
//            }
//            let request = URLRequest(url: url)
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let data = data {
//                    if let response = try? JSONDecoder().decode([TaskEntry]).self, from: data) {
//                        DispatchQueue.main.async {
//                            self.results = response
//                        }
//                        return
//                    }
//                }
//            }.resume()
//        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
