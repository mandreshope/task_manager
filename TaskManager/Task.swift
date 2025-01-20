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

    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
