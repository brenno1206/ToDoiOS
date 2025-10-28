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
            ManipulatingToDoView(viewModel: viewModel, type: ToDoManipulating.editGroup)
        } label: {
            HStack {
                Text(toDoGroup.title)
                    .foregroundStyle(.blueGrayForeground)
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
        .simultaneousGesture(TapGesture().onEnded {
            viewModel.selectedToDoGroup = toDoGroup
        })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
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
                    List {
                        ForEach(viewModel.toDoGroups){ toDoGroup in
                            Section(header: toDoGropuHeader(toDoGroup:  toDoGroup)) {
                                ForEach(toDoGroup.toDos) { toDoItem in
                                    NavigationLink {
                                        ManipulatingToDoView(viewModel: viewModel, type: ToDoManipulating.editItem)
                                            
                                    } label: {
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
                                    }
                                    .simultaneousGesture(TapGesture().onEnded {
                                        viewModel.selectedToDoItem = toDoItem
                                        viewModel.selectedToDoGroup = toDoGroup
                                    })
                                    
                                }
                                .onDelete { offsets in
                                    viewModel.deleteToDoItem(in: toDoGroup, at: offsets)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .background(.blueGrayBackground)
        }
    }
}

//#Preview {
//    HomeView()
//}
