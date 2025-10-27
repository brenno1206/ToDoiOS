//
//  HomeView.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = ToDoViewModel()
    func toDoGropuHeader(toDoGroup : ToDoGroup) -> some View {
        NavigationLink {
            AddToDoItemView(viewModel: viewModel, type: ToDoManipulating.editGroup, toDoGroupToEdit: toDoGroup)
        } label: {
            HStack {
                Text(toDoGroup.title)
                    .foregroundStyle(.blue)
                    .font(.system(size: 20, weight: .light))
                Spacer()
                Button {
                    // ALERT: isDeleting
                    // Are you sure you want to delect this group and all its tasks
                    viewModel.deleteGroup(toDoGroup: toDoGroup)
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.gray)
                        .padding(.trailing, 20)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("ToDo List")
                            .font(.system(size: 35, weight: .bold))
                            .padding(.leading, 25)
                        
                        Spacer()
                        Menu {
                            NavigationLink {
                                AddToDoItemView(viewModel: viewModel, type: .addItem)
                            } label: {
                                Text(ToDoManipulating.addItem.title)
                                Image(systemName: "plus")
                            }
                            NavigationLink {
                                AddToDoItemView(viewModel: viewModel, type: .addGroup)
                            } label: {
                                Text(ToDoManipulating.addGroup.title)
                                Image(systemName: "plus.rectangle.on.rectangle")
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .padding(.trailing, 20)
                                .font(.system(size: 30))
                                .foregroundStyle(.green)
                        }
                    }
                    List {
                        ForEach(viewModel.toDoGroups){ toDoGroup in
                            Section(header: toDoGropuHeader(toDoGroup:  toDoGroup)) {
                                
                                ForEach(toDoGroup.toDos) { toDoItem in
                                    NavigationLink {
                                        AddToDoItemView(viewModel: viewModel, type: ToDoManipulating.editItem, toDoItemToEdit: toDoItem)
                                    } label: {
                                        VStack {
                                            HStack {
                                                Image(systemName: toDoItem.isCompleted ? "checkmark.circle.fill" : "circle")
                                                    .foregroundStyle(toDoItem.isCompleted ? .green : .primary)
                                                Text(toDoItem.title)
                                                    .strikethrough(toDoItem.isCompleted)
                                                    .foregroundStyle(toDoItem.isCompleted ? .gray : .primary)
                                                
                                            }
                                            .padding(.vertical, 5)
                                        }
                                        .onTapGesture {
                                            viewModel.toggleCompletion(group: toDoGroup, item: toDoItem)
                                        }
                                    }
                                    
                                }
                                .onDelete { offsets in
                                    viewModel.deleteToDoItem(in: toDoGroup, at: offsets)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
