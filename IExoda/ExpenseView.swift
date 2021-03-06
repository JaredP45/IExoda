//
//  ContentView.swift
//  iExpense-Project
//
//  Created by Jared Paubel on 4/7/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//

/*
 !!README!!
    Notes:
      - Addview does not accept floating-point
            numbers... enter integers only (maybe fix later)
 */


import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID() // assigns random number id to item
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
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
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct ExpenseView: View {
        @ObservedObject var expenses = Expenses()
        @State private var showingAddExpense = false
        
        var body: some View {
            NavigationView {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text("$\(item.amount)")
                                .foregroundColor( item.amount <= 10 ? .green : item.amount <= 100 ? .orange : .red )
                        }
                    }
                    .onMove(perform: self.move)
                    .onDelete(perform: removeItems)
                }
            .navigationBarTitle("iExpense")
                    
                .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpense = true
                }){
                    Image(systemName: "plus")
                })
                    
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func move(from source : IndexSet, to destination : Int) {
        expenses.items.move(fromOffsets: source, toOffset: destination)
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
    }
}
