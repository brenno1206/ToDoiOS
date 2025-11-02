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
        
        Menu {
            Button {
                viewModel.selectedToDoGroup = toDoGroup
                viewModel.isEditingGroup = true
            } label: {
                Label("Edit Group", systemImage: "pencil")
            }
            Button(role: .destructive) {                viewModel.deleteGroup(toDoGroup: toDoGroup)
            } label: {
                Label("Delete Group", systemImage: "trash.fill")
            }
        } label: {
            HStack {
                Text(toDoGroup.title)
                    .foregroundStyle(.blueGrayForeground)
                    .font(.system(size: 20, weight: .regular))
                    .textCase(nil)
                Spacer()
            }
        }

    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    // HEADER
                    HStack {
                        Text("ToDo List")
                            .font(.system(size: 35, weight: .bold))
                            .padding(.leading, 25)
                            .foregroundStyle(.blueGrayForeground)
                        
                        Spacer()
                        Menu {
                            NavigationLink {
                                ManipulatingToDoView(viewModel: viewModel, type: .addItem)
                            } label: {
                                Text(ToDoManipulating.addItem.title)
                                Image(systemName: "plus")
                            }
                            NavigationLink {
                                ManipulatingToDoView(viewModel: viewModel, type: .addGroup)
                            } label: {
                                Text(ToDoManipulating.addGroup.title)
                                Image(systemName: "plus.rectangle.on.rectangle")
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .padding(.trailing, 20)
                                .font(.system(size: 30))
                                .foregroundStyle(.blueGrayForeground)
                        }
                    }
                    // BODY
                    if (viewModel.toDoGroups.isEmpty) {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Any ToDo added yet? Add one!")
                                .font(.system(size: 20, weight: .medium))
                                .padding(.horizontal, 25)
                                .foregroundStyle(.blueGrayForeground)
                            Spacer()
                        }
                        Spacer()
                    } else {
                        List {
                            ForEach(viewModel.toDoGroups){ toDoGroup in
                                
                                toDoGropuHeader(toDoGroup: toDoGroup)           .listRowBackground(Color.clear)               .listRowInsets(EdgeInsets(top: 20, leading: 25, bottom: 5, trailing: 20))                  .listRowSeparator(.hidden)
                                
                                Section {
                                    ForEach(toDoGroup.toDos) { toDoItem in
                                        
                                        VStack {
                                            HStack {
                                                Button {
                                                    viewModel.toggleCompletion(group: toDoGroup, item: toDoItem)
                                                } label: {
                                                    Image(systemName: toDoItem.isCompleted ? "checkmark.circle.fill" : "circle")
                                                        .foregroundStyle(toDoItem.isCompleted ? .blueGrayBackground : .primary)
                                                    Text(toDoItem.title)
                                                        .strikethrough(toDoItem.isCompleted)
                                                        .foregroundStyle(toDoItem.isCompleted ? .gray : .primary)
                                                }
                                                .buttonStyle(.plain)
                                                Spacer()
                                                Circle()
                                                    .frame(width: 12, height: 12)
                                                    .foregroundStyle(toDoItem.isCompleted ? Color.blueGrayBackground : toDoItem.priority.color)
                                            }
                                            .padding(.vertical, 5)
                                        }
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            viewModel.selectedToDoGroup = toDoGroup
                                            viewModel.selectedToDoItem = toDoItem
                                            viewModel.isEditingToDo = true
                                        }
                                        
                                    }
                                    .onDelete { offsets in
                                        viewModel.deleteToDoItem(in: toDoGroup, at: offsets)
                                    }
                                }
                                .listSectionSpacing(0)
                            }
                        }
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden)
                        
                    }
                }
            }
            .background(.blueGrayBackground)
            .navigationDestination(isPresented: $viewModel.isEditingToDo) {
                ManipulatingToDoView(viewModel: viewModel, type: .editItem)
            }
            .navigationDestination(isPresented: $viewModel.isEditingGroup) {
                ManipulatingToDoView(viewModel: viewModel, type: ToDoManipulating.editGroup)
            }
        }
    }
}

#Preview {
    HomeView()
}
