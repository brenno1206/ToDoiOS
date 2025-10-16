//
//  ToDoGroup.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import Foundation

struct ToDoGroup: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var toDos: [ToDoItem]
}
