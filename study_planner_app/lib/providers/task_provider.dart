import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert'; 
import '../models/task.dart';
import '../services/storage_service.dart';

class TaskProvider extends ChangeNotifier {
  final StorageService storage;
  List<Task> _tasks = [];
  bool remindersEnabled = true;

  TaskProvider({ required this.storage });

  List<Task> get tasks => List.unmodifiable(_tasks);

  Future<void> load() async {
    _tasks = await storage.loadTasks();
    remindersEnabled = await storage.getReminderEnabled();
    notifyListeners();
  }

  Future<void> addTask({
    required String title,
    String? description,
    required DateTime dueDate,
    DateTime? reminderTime,
  }) async {
    final task = Task(
      id: Uuid().v4(),
      title: title,
      description: description,
      dueDate: DateTime(dueDate.year, dueDate.month, dueDate.day),
      reminderTime: reminderTime,
    );
    _tasks.add(task);
    await _save(); 
    notifyListeners();
  }

  Future<void> updateTask(Task updated) async {
    final i = _tasks.indexWhere((t) => t.id == updated.id);
    if (i >= 0) {
      _tasks[i] = updated;
      await _save(); 
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((t) => t.id == id);
    await _save(); 
    notifyListeners();
  }

  Future<void> toggleDone(String id) async {
    final i = _tasks.indexWhere((t) => t.id == id);
    if (i >= 0) {
      _tasks[i].isDone = !_tasks[i].isDone;
      await _save(); 
      notifyListeners();
    }
  }

  List<Task> tasksForDate(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    return _tasks.where((t) =>
      DateTime(t.dueDate.year, t.dueDate.month, t.dueDate.day) == d
    ).toList();
  }

  Future<void> setRemindersEnabled(bool enabled) async {
    remindersEnabled = enabled;
    await storage.setReminderEnabled(enabled);
    notifyListeners();
  }


  Future<void> _save() async {
    await storage.saveTasks(_tasks);

    
    try {
      final data = _tasks.map((t) => t.toJson()).toList();
      final jsonString = const JsonEncoder.withIndent('  ').convert(data);
      debugPrint('\n📦 Saved tasks JSON:\n$jsonString\n');
    } catch (e) {
      debugPrint('⚠️ Error printing tasks JSON: $e');
    }
  }

  
  Set<DateTime> getMarkedDates() {
    return _tasks
        .map((t) => DateTime(t.dueDate.year, t.dueDate.month, t.dueDate.day))
        .toSet();
  }

 
  List<Task> dueReminders(DateTime now) {
    if (!remindersEnabled) return [];
    return _tasks.where((t) =>
        t.reminderTime != null &&
        t.reminderTime!.isBefore(now.add(const Duration(seconds: 1)))).toList();
  }
}
