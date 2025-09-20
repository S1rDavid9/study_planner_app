# Study Planner App - User Guide

## App Screenshots and Usage Guide

### 1. Today's Tasks Screen
**Main Features:**
- View all tasks due today
- Quick completion toggle with checkboxes
- Add new tasks with the floating action button
- Visual indicators for overdue tasks (red text)
- Reminder indicators (notification icon)
- Pull-to-refresh functionality

**What you'll see:**
- Empty state when no tasks for today
- List of tasks with title, description, and due time
- Completed tasks with strikethrough text
- Delete button for each task with confirmation dialog

### 2. Calendar Screen
**Main Features:**
- Monthly calendar view with task indicators
- Select any date to view tasks for that day
- Visual markers (dots) on dates with tasks
- Edit tasks directly from the calendar view
- Add new tasks for specific dates

**What you'll see:**
- Calendar widget with navigation between months
- Task list below calendar for selected date
- Edit and delete buttons for each task
- Empty state for dates with no tasks

### 3. Settings Screen
**Main Features:**
- Task statistics with progress visualization
- Total, completed, and pending task counts
- Progress bar showing completion percentage
- Data management options
- App information and about dialog

**What you'll see:**
- Statistics cards with icons and numbers
- Progress visualization
- Action buttons for refresh and clear data
- About section with app information

### 4. Add/Edit Task Screen
**Main Features:**
- Form with title and description fields
- Date and time picker integration
- Reminder toggle switch
- Form validation
- Save functionality with loading state

**What you'll see:**
- Input fields for task details
- Date and time selection interface
- Reminder toggle with description
- Save button in app bar

## Key User Flows

### Adding a New Task
1. Tap the (+) floating action button on Today or Calendar screen
2. Fill in the task title (required)
3. Add description (optional)
4. Select due date and time
5. Toggle reminder if desired
6. Tap Save

### Managing Tasks
1. View tasks on Today screen or select date in Calendar
2. Tap checkbox to mark complete/incomplete
3. Tap edit icon to modify task details
4. Tap delete icon and confirm to remove task

### Checking Progress
1. Navigate to Settings screen using bottom navigation
2. View statistics including total, completed, and pending tasks
3. See progress bar showing completion percentage
4. Refresh statistics with refresh button

### Reminder System
1. Enable reminders when creating/editing tasks
2. When app opens, popup shows tasks due today with reminders
3. Tap OK to dismiss reminder dialog

## Data Persistence
- All tasks are automatically saved to device storage
- Data persists between app sessions
- No internet connection required
- Clear all data option available in Settings

## Error Handling
- Form validation prevents saving incomplete tasks
- Error messages shown for save failures
- Confirmation dialogs for destructive actions
- Loading states during data operations