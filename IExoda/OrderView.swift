//
//  OrderView.swift
//  IExoda
//
//  Created by Jared Paubel on 4/30/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//

import SwiftUI

struct OrderItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    // FIXME let phone: Int
    let amount: Int
}

class Orders: ObservableObject {
    @Published var items = [OrderItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try?
                encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([OrderItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct OrderView: View {
        @ObservedObject var orders = Orders()
        @State private var showingAddOrder = false
        
        var body: some View {
            NavigationView {
                List {
                    ForEach(orders.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                // FIXME Text(item.phone)
                            }
                            Spacer()
                            Text("$\(item.amount)")
                                .foregroundColor( item.amount <= 10 ? .green : item.amount <= 100 ? .orange : .red )
                        }
                    }
                    .onMove(perform: self.move)
                    .onDelete(perform: removeItems)
                }
            .navigationBarTitle("Orders")
                    
                .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddOrder = true
                }){
                    Image(systemName: "plus")
                })
                    
            .sheet(isPresented: $showingAddOrder) {
                AddOrderView(orders: self.orders)
            }
        }
    }
    
    func move(from source : IndexSet, to destination : Int) {
        orders.items.move(fromOffsets: source, toOffset: destination)
    }
    
    func removeItems(at offsets: IndexSet) {
        orders.items.remove(atOffsets: offsets)
    }
}
struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
