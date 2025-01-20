# TaskManager

TaskManager is a simple iOS application built with SwiftUI and SwiftData. It allows users to manage their tasks with the ability to add, update, complete, and delete tasks. The app also supports task categorization, due dates, and notifications for upcoming tasks.

## Features

- Add tasks with title, category, and due date
- Search tasks by title
- Mark tasks as completed
- Delete tasks
- Display tasks with due dates
- Notifications for upcoming tasks
- Task categories: Work, Personal, Leisure
- Supports dark and light mode

## Requirements

- iOS 16.0 or later
- Xcode 14.0 or later
- Swift 5.7 or later

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/TaskManager.git
2.    Open the TaskManager.xcodeproj file in Xcode.
3.    Build and run the project on the iOS simulator or a physical device.

## Usage
    •    On the main screen, you can add tasks by entering a title, selecting a category (Work, Personal, Leisure), and setting a due date.
    •    You can view tasks in a list format with the option to search, mark as completed, and delete tasks.
    •    Tasks that are past due will be marked as “Late.”
    •    Notifications will be sent when the task’s due date is approaching.

## Code Explanation
    •    SwiftUI: The app is built using SwiftUI for a modern declarative UI.
    •    SwiftData: Tasks are stored using SwiftData, Apple’s modern data persistence framework.
    •    User Notifications: Notifications are scheduled for each task based on the due date.
    •    Dark and Light Mode: The app adapts to the system’s color scheme.

## Contributing

Feel free to fork this repository, open issues, and submit pull requests.

## License

This project is open source and available under the MIT License.

## Acknowledgments
    •    Thanks to Apple for SwiftUI and SwiftData.
    •    Thanks to the open-source community for providing inspiration and resources.

## Screenshots

Screenshots demonstrating the application's features.

<p align="center">
  <img src="https://github.com/mandreshope/task_manager/blob/main/screenshots/screen1.png?raw=true" width="250" title="Task list">
  <img src="https://github.com/mandreshope/task_manager/blob/main/screenshots/screen2.png?raw=true" width="250" title="Add a due date">
  <img src="https://github.com/mandreshope/task_manager/blob/main/screenshots/screen3.png?raw=true" width="250" title="Select a category">
</p>
