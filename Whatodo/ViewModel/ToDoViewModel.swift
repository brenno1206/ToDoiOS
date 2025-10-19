//
//  ToDoViewModel.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import Foundation
import Combine
import SwiftUI

class ToDoViewModel: ObservableObject {
    @Published var toDoGroups: [ToDoGroup] = [
        ToDoGroup(title: "Work", toDos: [
            ToDoItem(title: "Finish report",priority: .important),
            ToDoItem(title: "Code review",priority: .important)
        ]),
        ToDoGroup(title: "Personal", toDos: [
            ToDoItem(title: "Buy groceries",priority: .casual)
            ]),
        ToDoGroup(title: "UVV", toDos: [
            ToDoItem(title: "IC", priority: ToDoItemPriority.important),
            ToDoItem(title: "Prova", priority: ToDoItemPriority.urgent),
        ]),
        ToDoGroup(title: "Swift", toDos: [
        ]),
    ]
    
    func toggleCompletion(group: ToDoGroup, item: ToDoItem) {
            guard
                let groupIndex = toDoGroups.firstIndex(where: { $0.id == group.id }),
                let itemIndex = toDoGroups[groupIndex].toDos.firstIndex(where: { $0.id == item.id })
            else { return }

            toDoGroups[groupIndex].toDos[itemIndex].isCompleted.toggle()
        }
    func deleteToDoItem(in group: ToDoGroup, at offsets: IndexSet) {
            guard let groupIndex = toDoGroups.firstIndex(where: { $0.id == group.id }) else { return }
            toDoGroups[groupIndex].toDos.remove(atOffsets: offsets)
        }
    func deleteGroup(toDoGroup: ToDoGroup) {
        toDoGroups.remove(at: toDoGroups.firstIndex(of: toDoGroup)!)
        }
}

