//
//  Task.swift
//  TaskManager
//
//  Created by Mandresy on 20/01/2025.
//

import Foundation
import SwiftData

@Model
class Task {
    var title: String
    var isCompleted: Bool
    var category: String
    var dueDate: Date?

    init(title: String, category: String = "Général", dueDate: Date? = nil, isCompleted: Bool = false) {
        self.title = title
        self.category = category
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}
