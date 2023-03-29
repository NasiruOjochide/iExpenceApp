//
//  AddView.swift
//  iExpenceApp
//
//  Created by Danjuma Nasiru on 15/01/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var expenses : Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Binding var TotalExpense : Double
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                
                TextField("Amount", value: $amount, format: .currency(code: "USD")).keyboardType(.numberPad)
                
                
            }.navigationTitle("Add New Expense")
                .toolbar(content: {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        TotalExpense = 0.0
                            for item in expenses.items{
                                TotalExpense += item.amount
                            }
                            
                        
                        UserDefaults.standard.set(TotalExpense, forKey: "TotalExpense")
                        
                        dismiss()
                    }
                })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), TotalExpense: ContentView().$totalExpense)
    }
}
    
