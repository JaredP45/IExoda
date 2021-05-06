//
//  AddOrderView.swift
//  IExoda
//
//  Created by Jared Paubel on 4/30/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//

import SwiftUI

struct AddOrderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var orders: Orders
    
    static let types = ["Business", "Personal"]
    
    @State private var name = ""
    @State private var type = "Personal"
    // FIXME @State private var phone = ""
    @State private var amount = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
// FIXME        TextField("Phone Number", text: $phone)
//                    .keyboardType(.numberPad)
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
        .navigationBarTitle("Add New Order")
                
        .navigationBarItems(trailing:
            Button("Save"){
                if let actualAmount = Int(self.amount)
                {
                    let item = OrderItem(name: self.name, type: self.type, amount: actualAmount)
                    self.orders.items.append(item)
                    self.presentationMode
                        .wrappedValue.dismiss()
                } else {
                    self.showAlert = true
                }
        })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Warning!"), message: Text("You must complete the fields with the correct values!"), dismissButton: .default(Text("Okay")))
            }
        }
    }
}


struct AddOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrderView(orders: Orders())
    }
}
