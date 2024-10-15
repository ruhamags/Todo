import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String) onSave;

  AddTaskScreen({required this.onSave});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave(_taskController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
