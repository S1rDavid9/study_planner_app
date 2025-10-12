# Study Planner — Smart Task Management App

A modern, feature-rich Flutter application designed to help students manage their study schedules efficiently with an elegant dark UI, smooth animations, and intelligent reminders.

![App Banner] <img width="1355" height="761" alt="Screenshot 2025-10-12 181649" src="https://github.com/user-attachments/assets/f99aa1f6-5853-4b65-a541-b14a539cdc26" />


## 📱 Features

### 🎯 Task Management
- **Create, Edit, Delete**: Full CRUD operations for tasks
- **Task Properties**: 
  - Title and description
  - Date and time scheduling
  - Optional reminder notifications
  - Completion status tracking
- **Smart Organization**: Tasks automatically sorted by date and time

### 📅 Daily Progress View (Today Screen)
- Displays all tasks scheduled for the current day
- **Animated Progress Bar**: Visual completion tracking using `AnimationController`
- Real-time progress calculation based on completed tasks
- Clean, focused interface for daily productivity

![Today Screen] <img width="296" height="614" alt="Screenshot 2025-10-12 191028" src="https://github.com/user-attachments/assets/c3808639-b339-4de4-a6f1-5b23e9f45003" />


### 📆 Calendar Screen
- Interactive calendar view for long-term planning
- Date selection to view tasks for any specific day
- Visual indicators for dates with scheduled tasks
- Seamless navigation between days

![Calendar Screen] <img width="286" height="607" alt="Screenshot 2025-10-12 191046" src="https://github.com/user-attachments/assets/0eb97427-45da-4e53-94cf-04b47304448f" />


### ⏰ Smart Reminders
- Time-based popup alerts when tasks are due
- Reminder dialog displays:
  - Task title and description
  - Formatted due date and time
- **Dismiss button** prevents duplicate notifications
- Background reminder checking

![Reminder Dialog] 

### 💾 Persistent Storage
- Local data storage using JSON
- Automatic save on task updates
- Data loads automatically on app startup
- No internet connection required

### 🎨 User Interface
- **Dark Theme**: Elegant navy background with yellow accents (`#FFC300`)
- **Smooth Animations**: Fluid transitions and progress animations
- **Bottom Navigation**: Quick access to Today, Calendar, and Settings
- **Responsive Design**: Optimized for various screen sizes

![Add/Edit Task Screen] <img width="297" height="611" alt="Screenshot 2025-10-12 191114" src="https://github.com/user-attachments/assets/0803ad7d-96da-40fd-872e-3e819f7b3d51" />


![Settings Screen] <img width="301" height="602" alt="Screenshot 2025-10-12 191059" src="https://github.com/user-attachments/assets/c143735f-fd92-4b6c-bd8f-91ca9082dae0" />


## 🏗️ Architecture

### Project Structure

```
lib/
├── main.dart                          # App entry point with MainShell
├── models/
│   └── task.dart                      # Task data model
├── providers/
│   └── task_provider.dart             # State management (CRUD & filtering)
├── services/
│   └── storage_service.dart           # JSON storage handler
├── screens/
│   ├── today_screen.dart              # Daily progress view
│   ├── calendar_screen.dart           # Calendar view
│   ├── settings_screen.dart           # App preferences
│   └── add_edit_task_screen.dart      # Task creation/editing form
└── widgets/
    └── task_tile.dart                 # Reusable task display component
```

### Key Components

#### `main.dart`
- Application entry point
- `MainShell` widget manages bottom navigation
- Handles reminder system initialization and checking

#### `providers/task_provider.dart`
- State management using Provider pattern
- CRUD operations (Create, Read, Update, Delete)
- Task filtering by date
- Progress calculation

#### `services/storage_service.dart`
- Local JSON file storage
- Asynchronous save/load operations
- Data persistence between app sessions

#### `models/task.dart`
- Task data structure
- Properties: title, description, date, time, reminderTime, isDone
- JSON serialization/deserialization

#### Screens
- **Today Screen**: Daily task list with animated progress tracking
- **Calendar Screen**: Date-based task viewing with calendar picker
- **Settings Screen**: App configuration and preferences
- **Add/Edit Task Screen**: Form for creating and modifying tasks

#### Widgets
- **TaskTile**: Custom reusable component for displaying task information

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android Emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd study-planner
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK**
```bash
flutter build apk --release
```

**Android App Bundle**
```bash
flutter build appbundle --release
```

**iOS**
```bash
flutter build ios --release
```

## 🎨 Customization

### Theme Colors
The app uses a consistent color scheme defined in `main.dart`:
- **Primary Color**: Yellow (`#FFC300`)
- **Background**: Navy (`#0A1128`)
- **Surface**: Dark Blue (`#1C2541`)

To customize colors, modify the `ThemeData` in `main.dart`.

### Adding New Features
1. Create new models in `models/`
2. Add business logic to `providers/`
3. Create UI screens in `screens/`
4. Update navigation in `main.dart`

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0           # State management
  intl: ^0.18.0              # Date formatting
  path_provider: ^2.0.0      # File system access
  # Add other dependencies as needed
```

## 🐛 Known Issues

- Reminder notifications work only when app is in foreground
- Consider implementing background notification service for production

## 🔮 Future Enhancements

- [ ] Push notifications for reminders
- [ ] Task categories and tags
- [ ] Statistics and analytics dashboard
- [ ] Cloud sync across devices
- [ ] Pomodoro timer integration
- [ ] Dark/Light theme toggle
- [ ] Export tasks to PDF/CSV

## 🤝 Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Authors

- Akachi Nwanze

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for UI guidelines
- Community contributors

---

**Made with ❤️ using Flutter**
