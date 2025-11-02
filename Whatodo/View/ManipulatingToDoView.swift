//
//  AddToDoItemView.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import SwiftUI

struct ManipulatingToDoView: View {
    @ObservedObject var viewModel: ToDoViewModel
    
    var type: ToDoManipulating
    
    @State private var title: String = ""
    @State private var group: ToDoGroup? = nil
    @State private var priority: ToDoItemPriority = .casual
    
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text(type.title)
                .font(.system(size: 35, weight: .bold))
                .padding(.leading, 25)
                .padding(.top, 30)
                .foregroundStyle(Color(.blueGrayForeground))
            TextField(
                "Title", text: $title)
            .font(.system(size: 15))
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 30)
            .padding(.top)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            if(type == .addItem || type == .editItem) {
                Form {
                    if(type == .addItem) {
                        Picker("Choose Group", selection: $group) {
                            ForEach(viewModel.toDoGroups) { toDoGroup in
                                Text(toDoGroup.title)
                                    .tag(Optional(toDoGroup))
                            }
                        }
                    }
                    Picker("Coose Priority", selection: $priority) {
                        ForEach(ToDoItemPriority.allCases) {toDoItemPriority in
                            Text(toDoItemPriority.title)
                        }
                    }
                }
                .padding(.horizontal)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .frame(maxHeight: 200)
            }
            
            Spacer()
            Button {
                if viewModel.AddToDo(type: type, title: title, group: group, priority: priority) {
                    title = ""
                    priority = .casual
                    dismiss()
                }
            } label: {
                Text((type == .addItem || type == .addGroup) ? "Add" : "Save")
                    .foregroundStyle(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.blueGrayForeground)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 20)
            Spacer()
            

        }
        .background(.blueGrayBackground)
        .onAppear() {
            switch type {
                case .editGroup:
                        if let selectedToDoGroup = viewModel.selectedToDoGroup {
                            title = selectedToDoGroup.title
                        }
                        
                    case .editItem:
                        if let selectedToDoItem = viewModel.selectedToDoItem {
                            title = selectedToDoItem.title
                            priority = selectedToDoItem.priority
                            group = viewModel.selectedToDoGroup
                        }
                        
                    case .addItem:
                        title = ""
                        priority = .casual
                        
                    case .addGroup:
                        title = ""
                    }
        }
    }
}

//#Preview {
//    ManipulatingToDoView(viewModel: ToDoViewModel(), type: .addItem)
//}
