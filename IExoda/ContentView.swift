//
//  ContentView.swift
//  IExoda
//
//  Created by Jared Paubel on 4/28/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//
//Button(action: {
//    print("Button Action")
//}) {
//    Text("Button Label")
//        .padding(10.0)
//        .overlay(RoundedRectangle(cornerRadius: 10.0)
//            .stroke(lineWidth: 2.0)
//            .shadow(color: .blue, radius: 10.0)
//    )
//}

import SwiftUI


struct ContentView: View {
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("IExoda")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(Color.blue)
                
                Text("Quote")
                    .padding(.leading, 20)
                
                
                Text("DateTime")
                    .padding(.leading, 20)
                
                
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
