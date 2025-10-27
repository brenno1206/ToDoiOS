//
//  AddToDoItemView.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import SwiftUI

struct AddToDoItemView: View {
    @ObservedObject var viewModel: ToDoViewModel
    var type: ToDoManipulating
    var toDoGroupToEdit: ToDoGroup?
    var toDoItemToEdit: ToDoItem?
    
    var body: some View {
        VStack{
            Text(type.title)
        }
    }
}

//#Preview {
//    AddToDoItemView(viewModel: ToDoViewModel())
//}
