import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String) onSave;
  final String? initialTitle;

  AddTaskScreen({required this.onSave, this.initialTitle});


  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = TextEditingController();
  @override
  void initState(){
    super.initState();
    if (widget.initialTitle != null){
      _taskController.text = widget.initialTitle!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialTitle != null ? 'Edit Task': 'Add Task'),
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
