import 'package:flutter/material.dart';
import '../models/task.dart';
import 'task_database.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks(); // Load tasks initially
  }

  // Load tasks from the database
  Future<void> loadTasks() async {
    _tasks = await TaskDatabase.instance.getTasks();
    notifyListeners(); // Notify listeners to rebuild UI
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    final id = await TaskDatabase.instance.createTask(task);
    task.id = id;
    _tasks.add(task);
    notifyListeners();
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    await TaskDatabase.instance.updateTask(task);
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  // Toggle task completion status
  Future<void> toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await TaskDatabase.instance.updateTask(task);
    notifyListeners();
  }

  // Delete a task
  Future<void> deleteTask(Task task) async {
    await TaskDatabase.instance.deleteTask(task.id!);
    _tasks.remove(task);
    notifyListeners();
  }
}
