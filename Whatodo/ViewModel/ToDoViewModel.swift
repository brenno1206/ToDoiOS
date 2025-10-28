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
    @Published var toDoGroups: [ToDoGroup] = []
    
    @Published var selectedToDoItem: ToDoItem?
    @Published var selectedToDoGroup: ToDoGroup?
    
    
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
        guard let idx = toDoGroups.firstIndex(where: { $0.id == toDoGroup.id }) else { return }
        toDoGroups.remove(at: idx)
    }
    
    @discardableResult
    func AddToDo(type: ToDoManipulating, title: String, group: ToDoGroup? = nil, priority: ToDoItemPriority? = nil) -> Bool{
        switch type {
        case .addItem:
            guard !title.isEmpty,
                  let group = group,
                  let priority = priority,
                  let groupIndex = toDoGroups.firstIndex(where: { $0.id == group.id })
            else { return false }
            
            let newItem = ToDoItem(title: title, isCompleted: false, priority: priority)
            toDoGroups[groupIndex].toDos.append(newItem)
            return true
            
        case .addGroup:
            guard !title.isEmpty else { return false }
            let newGroup = ToDoGroup(title: title, toDos: [])
            toDoGroups.append(newGroup)
            return true
            
        case .editGroup:
            guard let selected = selectedToDoGroup,
                  !title.isEmpty,
                  let index = toDoGroups.firstIndex(where: { $0.id == selected.id })
            else { return false }
            toDoGroups[index].title = title
            selectedToDoGroup = toDoGroups[index]
            return true
            
        case .editItem:
            guard let selectedItem = selectedToDoItem,
                  let group = group,
                  let groupIndex = toDoGroups.firstIndex(where: { $0.id == group.id }),
                  let priority = priority,
                  let itemIndex = toDoGroups[groupIndex].toDos.firstIndex(where: { $0.id == selectedItem.id })
            else { return false }
            
            if !title.isEmpty {
                toDoGroups[groupIndex].toDos[itemIndex].title = title
                toDoGroups[groupIndex].toDos[itemIndex].priority = priority
            }
            
            return true
        }
    }
    
}
