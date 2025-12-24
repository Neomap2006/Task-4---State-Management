import 'package:flutter/foundation.dart';

class Task {
  String name;
  bool isDone;

  Task({required this.name, this.isDone = false});
}

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: "Tidur Siang"),
    Task(name: "Lari Pagi"),
    Task(name: "Balap Karung"),
  ];

  List<Task> get tasks => List.unmodifiable(_tasks);
  int get taskCount => _tasks.length;

  void addTask(String newTaskTitle) {
    if (newTaskTitle.trim().isNotEmpty) {
      _tasks.add(Task(name: newTaskTitle.trim()));
      notifyListeners();
    }
  }

  void toggleTask(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}