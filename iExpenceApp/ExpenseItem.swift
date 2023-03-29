//
//  ExpenseItem.swift
//  iExpenceApp
//
//  Created by Danjuma Nasiru on 15/01/2023.
//

import Foundation

//having our struct conform to identifiable makes it so that each instance of the struct is unique. Hence when we have to loop through instances of our struct for instance using a foreach, we wouldn't need to attach id as swiftui already knows that it conforms to identifiable and hence it must be natuarally unique
struct ExpenseItem : Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
}
