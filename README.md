# Study Planner App

A Flutter application that helps students manage their tasks and deadlines with an intuitive interface and local data persistence.

## Features

- **Bottom Navigation**: Three main screens for easy navigation
  - Today's Tasks: View and manage tasks due today
  - Calendar: Browse tasks by date with calendar view
  - Settings: App statistics and data management

- **Task Management**: Complete CRUD operations for tasks
  - Create tasks with title, description, due date, and optional reminders
  - Edit existing tasks
  - Mark tasks as completed
  - Delete tasks with confirmation

- **Local Storage**: Tasks are saved locally using SharedPreferences in JSON format
  - Data persists between app sessions
  - No internet connection required

- **Reminder System**: Simulated notification system
  - Pop-up reminders when the app opens
  - Shows tasks due today that have reminders enabled

- **Statistics**: Track your productivity
  - Total tasks count
  - Completed vs pending tasks
  - Progress visualization

## Technical Details

### Architecture
- **Model-View Pattern**: Clean separation of data models and UI
- **Services Layer**: Dedicated storage service for data persistence
- **Modular Screens**: Each screen is a separate, reusable component

### Dependencies
- `flutter`: Flutter SDK
- `shared_preferences: ^2.2.2`: Local data storage
- `table_calendar: ^3.0.9`: Calendar widget for date selection
- `cupertino_icons: ^1.0.2`: iOS-style icons

### Project Structure
```
lib/
├── main.dart                 # App entry point and navigation
├── models/
│   └── task.dart            # Task data model
├── services/
│   └── storage_service.dart # SharedPreferences handling
├── screens/
│   ├── today_tasks_screen.dart    # Today's tasks view
│   ├── calendar_screen.dart       # Calendar view
│   ├── settings_screen.dart       # Settings and statistics
│   └── add_task_screen.dart       # Task creation/editing
└── widgets/                 # Reusable UI components
```

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

### Building
- **Android**: `flutter build apk`
- **iOS**: `flutter build ios`

## Usage

1. **Adding Tasks**: Use the floating action button (+) to create new tasks
2. **Viewing Tasks**: Navigate between Today and Calendar views using bottom navigation
3. **Managing Tasks**: Tap checkboxes to mark complete, use edit/delete buttons for modifications
4. **Reminders**: Enable reminders when creating tasks to get pop-up notifications
5. **Statistics**: Check the Settings screen for productivity insights

## Testing

Run tests with:
```bash
flutter test
```

The app includes unit tests for the Task model covering:
- Task creation and initialization
- JSON serialization/deserialization
- Task state management (completion, due dates)
- Data validation

## Features in Detail

### Today's Tasks Screen
- Displays all tasks due for the current date
- Shows task status (completed/pending)
- Indicates overdue tasks with red styling
- Pull-to-refresh functionality
- Quick task completion toggle

### Calendar Screen
- Monthly calendar view with task indicators
- Select any date to view tasks for that day
- In-line task editing and management
- Visual markers for dates with tasks

### Settings Screen
- Task statistics with progress visualization
- Data management options (clear all data)
- App information and version details
- Storage information

### Add/Edit Task Screen
- Form validation for required fields
- Date and time picker integration
- Optional reminder toggle
- Support for both creating new tasks and editing existing ones

## Data Storage

Tasks are stored locally using Flutter's SharedPreferences package:
- Data format: JSON strings in a list
- Automatic persistence across app sessions
- No external dependencies or internet required
- Easy to backup/restore (stored in device preferences)

## Future Enhancements

Potential improvements for future versions:
- Real notification system using local notifications
- Task categories and priority levels
- Export/import functionality
- Dark mode support
- Task search and filtering
- Recurring task support