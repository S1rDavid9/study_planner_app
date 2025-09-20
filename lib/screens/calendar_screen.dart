import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';
import '../services/storage_service.dart';
import 'add_task_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late final ValueNotifier<List<Task>> _selectedTasks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Task>> _tasksByDate = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _selectedTasks = ValueNotifier(_getTasksForDay(_selectedDay!));
    _loadAllTasks();
  }

  @override
  void dispose() {
    _selectedTasks.dispose();
    super.dispose();
  }

  Future<void> _loadAllTasks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final tasks = await StorageService.loadTasks();
      final tasksByDate = <DateTime, List<Task>>{};

      for (final task in tasks) {
        final date = DateTime(
          task.dueDate.year,
          task.dueDate.month,
          task.dueDate.day,
        );
        
        if (tasksByDate[date] == null) {
          tasksByDate[date] = [];
        }
        tasksByDate[date]!.add(task);
      }

      setState(() {
        _tasksByDate = tasksByDate;
        _isLoading = false;
      });

      _selectedTasks.value = _getTasksForDay(_selectedDay!);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Task> _getTasksForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _tasksByDate[normalizedDay] ?? [];
  }

  Future<void> _toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await StorageService.updateTask(updatedTask);
    _loadAllTasks();
  }

  Future<void> _deleteTask(Task task) async {
    await StorageService.deleteTask(task.id);
    _loadAllTasks();
  }

  void _showDeleteConfirmation(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: Text('Are you sure you want to delete "${task.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteTask(task);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TableCalendar<Task>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: CalendarFormat.month,
                  eventLoader: _getTasksForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: false,
                    markersMaxCount: 3,
                    markerDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      _selectedTasks.value = _getTasksForDay(selectedDay);
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ValueListenableBuilder<List<Task>>(
                    valueListenable: _selectedTasks,
                    builder: (context, value, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Tasks for ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: value.isEmpty
                                ? const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.event_available,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'No tasks for this date',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: value.length,
                                    itemBuilder: (context, index) {
                                      final task = value[index];
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 4,
                                        ),
                                        child: ListTile(
                                          leading: Checkbox(
                                            value: task.isCompleted,
                                            onChanged: (_) => _toggleTaskCompletion(task),
                                          ),
                                          title: Text(
                                            task.title,
                                            style: TextStyle(
                                              decoration: task.isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                              color: task.isCompleted
                                                  ? Colors.grey
                                                  : null,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if (task.description.isNotEmpty)
                                                Text(
                                                  task.description,
                                                  style: TextStyle(
                                                    color: task.isCompleted
                                                        ? Colors.grey
                                                        : null,
                                                  ),
                                                ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.schedule,
                                                    size: 16,
                                                    color: task.isOverdue
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${task.dueDate.hour.toString().padLeft(2, '0')}:${task.dueDate.minute.toString().padLeft(2, '0')}',
                                                    style: TextStyle(
                                                      color: task.isOverdue
                                                          ? Colors.red
                                                          : Colors.grey,
                                                      fontWeight: task.isOverdue
                                                          ? FontWeight.bold
                                                          : null,
                                                    ),
                                                  ),
                                                  if (task.hasReminder) ...[
                                                    const SizedBox(width: 8),
                                                    const Icon(
                                                      Icons.notifications,
                                                      size: 16,
                                                      color: Colors.orange,
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () async {
                                                  final result = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => AddTaskScreen(task: task),
                                                    ),
                                                  );
                                                  if (result == true) {
                                                    _loadAllTasks();
                                                  }
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () => _showDeleteConfirmation(task),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                task: Task(
                  id: '',
                  title: '',
                  description: '',
                  dueDate: _selectedDay ?? DateTime.now(),
                ),
              ),
            ),
          );
          if (result == true) {
            _loadAllTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}