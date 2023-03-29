//
//  ContentView.swift
//  iExpenceApp
//
//  Created by Danjuma Nasiru on 15/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State var totalExpense = UserDefaults.standard.double(forKey: "TotalExpense")
    @State private var showingAddExpense = false
    @State private var total = 0.0
    
    var body: some View {
        
        NavigationView{
            VStack{
                //Text("iExpense").font(.title.bold())
                
                List {
                    ForEach(expenses.items) { item in
                        HStack{
                            VStack{
                                Text(item.name).font(.headline)
                                Text(item.type).font(.body.italic())
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "NGN")).foregroundColor(item.amount < 10 ? .green : item.amount > 10 && item.amount < 100 ? .yellow : .red )
                            
                        }
                        .accessibilityElement()
                        .accessibilityLabel("\(item.name), \(item.amount)")
                        .accessibilityHint(item.type)
                    }.onDelete(perform: removeItems)
                    
                }
                Spacer()
                
                Text("Total Expense is: $\(totalExpense.formatted())").font(Font.title.bold()).frame( height: 100.0)
                
                
                Spacer()
            }.navigationTitle("iExpense")
                .sheet(isPresented: $showingAddExpense){
                    AddView(expenses: expenses, TotalExpense: $totalExpense)
                    
                }
                .toolbar {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            
            
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
        totalExpense = 0.0
        for item in expenses.items{
            totalExpense += item.amount
        }
        UserDefaults.standard.set(totalExpense, forKey: "TotalExpense")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
