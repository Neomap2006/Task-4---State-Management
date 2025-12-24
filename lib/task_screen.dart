import 'package:flutter/material.dart';

class Task {
  String name;
  bool isDone;

  Task({required this.name, this.isDone = false});
}

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [
    Task(name: "Tidur Siang"),
    Task(name: "Lari Pagi"),
    Task(name: "Balap Karung"),
  ];

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Tugas dihapus")),
    );
  }

  void showAddTaskBottomSheet() {
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
            // Teks "Tambah Tugas" di tengah
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

            // TextField TANPA hint text
            TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "", // Kosongkan hint
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purpleAccent, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Tombol Add full width dan di tengah
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    setState(() {
                      tasks.add(Task(name: controller.text.trim()));
                    });
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
        title: Text('Provider To-Do (${tasks.length})'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Dismissible(
            key: Key(task.name + index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white, size: 36),
            ),
            onDismissed: (direction) {
              deleteTask(index);
            },
            child: CheckboxListTile(
              title: Text(
                task.name,
                style: TextStyle(
                  fontSize: 18,
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: task.isDone ? Colors.grey : Colors.black,
                ),
              ),
              value: task.isDone,
              onChanged: (value) => toggleTask(index),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
              secondary: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 28,
                ),
                onPressed: () => deleteTask(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: showAddTaskBottomSheet,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}