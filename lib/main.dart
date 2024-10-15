import 'package:flutter/material.dart';
import 'screens/todo_list_screen.dart'; // Import the TodoListScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App', // The title of your app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Basic theme for your app
      ),
      home: TodoListScreen(), // Set TodoListScreen as the home screen
    );
  }
}
