//
//  HomeView.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = ToDoViewModel()
    
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("ToDo List")
                        .font(.system(size: 35, weight: .bold))
                        .padding(.leading)
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                        .padding(.trailing, 20)
                        .font(.system(size: 30))
                }
                List {
                    ForEach(viewModel.toDoGroups){ toDoGroup in
                        Section(header: Text(toDoGroup.title)) {
                            ForEach(toDoGroup.toDos) { toDoItem in
                                VStack {
                                    HStack {
                                        Image(systemName: toDoItem.isCompleted ? "checkmark.circle.fill" : "circle")
                                        Text(toDoItem.title)
                                    }
                                    .padding(.vertical, 5)
                                }
                                .onTapGesture {
                                    viewModel.toggleCompletion(group: toDoGroup, item: toDoItem)
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
