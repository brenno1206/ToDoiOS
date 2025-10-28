//
//  ToDoItemPriority.swift
//  Whatodo
//
//  Created by Brenno Gomes Breda on 16/10/25.
//

import Foundation
import SwiftUI

enum ToDoItemPriority: String, CaseIterable, Identifiable, ShapeStyle {
    case casual
    case important
    case urgent
    
    var id: Self { self }
    var title: String {
        switch self {
        case .casual:
            return "Casual"
        case .important:
            return "Important"
        case .urgent:
            return "Urgent"
        }
    }
    
    var color: Color {
        switch self {
        case .casual:
            return .green
        case .important:
            return .yellow
        case .urgent:
            return .red
        }
    }
}

