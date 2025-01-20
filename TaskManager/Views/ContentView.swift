//
//  ContentView.swift
//  TaskManager
//
//  Created by Mandresy on 20/01/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) private var modelContext  // Accessing the SwiftData context
    @Query private var tasks: [Task]  // Query to get all tasks
    @State private var newTaskTitle: String = ""
    @State private var searchText: String = ""
    @State private var selectedCategory: String = "Work"
    @State private var dueDate: Date = Date()

    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return tasks
        } else {
            return tasks.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                SearchBar(text: $searchText)
                    .padding()
                // Add new task
                HStack {
                    VStack {
                        TextField("New Task", text: $newTaskTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        DatePicker(
                            "Due Date", selection: $dueDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(CompactDatePickerStyle())
                    }

                    Picker("Category", selection: $selectedCategory) {
                        ForEach(
                            ["Work", "Personal", "Leisure"], id: \.self
                        ) { category in
                            Text(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
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
                    ForEach(filteredTasks) { task in
                        HStack {
                            Text(task.title)
                                .strikethrough(task.isCompleted, color: .gray)
                            Spacer()
                            Text(task.category)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            if let dueDate = task.dueDate,
                                dueDate < Date() && !task.isCompleted
                            {
                                Text("Late")
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                            Button(action: {
                                toggleTaskCompletion(task)
                            }) {
                                Image(
                                    systemName: task.isCompleted
                                        ? "checkmark.circle.fill" : "circle"
                                )
                                .foregroundColor(
                                    task.isCompleted ? .green : .gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteTasks)
                }
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .navigationTitle("My Tasks")
        }
    }

    // Add a task
    private func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        let task = Task(
            title: newTaskTitle, category: selectedCategory, dueDate: dueDate)
        modelContext.insert(task)
        newTaskTitle = ""
        scheduleNotification(for: task)
    }

    // Toggle task completion status
    private func toggleTaskCompletion(_ task: Task) {
        task.isCompleted.toggle()
    }

    // Delete a task
    private func deleteTasks(at offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach { modelContext.delete($0) }
    }

    // Schedule a notification
    private func scheduleNotification(for task: Task) {
        guard let dueDate = task.dueDate else { return }

        let content = UNMutableNotificationContent()
        content.title = "Reminder: \(task.title)"
        content.body =
            "Your task in the \(task.category) category is due."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: dueDate.timeIntervalSinceNow, repeats: false)

        let request = UNNotificationRequest(
            identifier: task.title, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(
                    "Error scheduling notification: \(error.localizedDescription)"
                )
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}
