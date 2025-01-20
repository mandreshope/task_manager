//
//  ContentView.swift
//  TaskManager
//
//  Created by Mandresy on 20/01/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext // Accessing the SwiftData context
    @Query private var tasks: [Task] // Query to get all tasks
    @State private var newTaskTitle: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Add new task
                HStack {
                    TextField("New task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addTask) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding()

                // Task list
                List {
                    ForEach(tasks) { task in
                        HStack {
                            Text(task.title)
                                .strikethrough(task.isCompleted, color: .gray)
                            Spacer()
                            Button(action: {
                                toggleTaskCompletion(task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteTasks)
                }
            }
            .navigationTitle("My tasks")
        }
    }

    // Add new task
    private func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        let task = Task(title: newTaskTitle)
        modelContext.insert(task)
        newTaskTitle = ""
    }

    // Mark a task as completed
    private func toggleTaskCompletion(_ task: Task) {
        task.isCompleted.toggle()
    }

    // Delete a task
    private func deleteTasks(at offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach { modelContext.delete($0) }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: false)
}
