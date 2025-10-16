//
//  ToDoItemPriority.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import Foundation

enum ToDoItemPriority: String {
    case casual
    case important
    case urgent
    
    var title : String {
        return self.rawValue.lowercased()
    }
    
}
