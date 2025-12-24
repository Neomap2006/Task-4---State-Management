import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_data.dart'; // import yang baru kita buat

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  void _showAddTaskBottomSheet(BuildContext context) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: EdgeInsets.only(
          left: 32,
          right: 32,
          top: 40,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Tambah Tugas",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purpleAccent, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(controller.text);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 3,
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<TaskData>(
          builder: (context, taskData, child) =>
              Text('Provider To-Do (${taskData.taskCount})'),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TaskData>(
        builder: (context, taskData, child) {
          return ListView.builder(
            itemCount: taskData.tasks.length,
            itemBuilder: (context, index) {
              final task = taskData.tasks[index];
              return Dismissible(
                key: Key(task.name + index.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white, size: 36),
                ),
                onDismissed: (_) => taskData.deleteTask(index),
                child: CheckboxListTile(
                  title: Text(
                    task.name,
                    style: TextStyle(
                      fontSize: 18,
                      decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                      color: task.isDone ? Colors.grey : Colors.black,
                    ),
                  ),
                  value: task.isDone,
                  onChanged: (_) => taskData.toggleTask(index),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                  secondary: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                    onPressed: () => taskData.deleteTask(index),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => _showAddTaskBottomSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}