//
//  ToDoItem.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import Foundation

struct ToDoItem: Identifiable {
    let id: UUID
    var title: String
    var isCompleted = false
    var priority: ToDoItemPriority
}

extension ToDoItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
