//
//  ToDoManipulating.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 27/10/25.
//

import Foundation

enum ToDoManipulating: String, CaseIterable, Identifiable {
    case addItem, editItem, addGroup, editGroup
    
    var id: Self { self }
    var title : String{
        switch self {
        case .addItem:
            return "Add Item"
        case .editItem:
            return "Edit Item"
        case .addGroup:
            return "Add Group"
        case .editGroup:
            return "Edit Group"
        }
    }
}
