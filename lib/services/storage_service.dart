import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const String _tasksKey = 'tasks';

  static Future<List<Task>> loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getStringList(_tasksKey) ?? [];
      
      return tasksJson.map((taskString) {
        final taskMap = jsonDecode(taskString) as Map<String, dynamic>;
        return Task.fromJson(taskMap);
      }).toList();
    } catch (e) {
      print('Error loading tasks: $e');
      return [];
    }
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = tasks.map((task) => jsonEncode(task.toJson())).toList();
      await prefs.setStringList(_tasksKey, tasksJson);
    } catch (e) {
      print('Error saving tasks: $e');
    }
  }

  static Future<void> addTask(Task task) async {
    final tasks = await loadTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  static Future<void> updateTask(Task updatedTask) async {
    final tasks = await loadTasks();
    final index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
      await saveTasks(tasks);
    }
  }

  static Future<void> deleteTask(String taskId) async {
    final tasks = await loadTasks();
    tasks.removeWhere((task) => task.id == taskId);
    await saveTasks(tasks);
  }

  static Future<List<Task>> getTasksForDate(DateTime date) async {
    final tasks = await loadTasks();
    return tasks.where((task) {
      return task.dueDate.year == date.year &&
             task.dueDate.month == date.month &&
             task.dueDate.day == date.day;
    }).toList();
  }

  static Future<List<Task>> getTodaysTasks() async {
    final now = DateTime.now();
    return getTasksForDate(now);
  }

  static Future<List<Task>> getTasksWithReminders() async {
    final tasks = await loadTasks();
    return tasks.where((task) => task.hasReminder && !task.isCompleted).toList();
  }
}