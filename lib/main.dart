import 'package:flutter/material.dart';
import 'task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do setState',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: TaskScreen(),
    );
  }
}