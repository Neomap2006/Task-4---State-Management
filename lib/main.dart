import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_data.dart';
import 'task_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do Provider',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const TaskScreen(),
    );
  }
}
