//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Mandresy on 20/01/2025.
//

import SwiftData
import SwiftUI

@main
struct TaskManagerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(
                for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    init() {
        requestNotificationPermission()
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [
            .alert, .sound, .badge,
        ]) { granted, error in
            if let error = error {
                print("Erreur d'autorisation : \(error.localizedDescription)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
