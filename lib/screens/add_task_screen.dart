import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String, String) onSave;
  final String? initialTitle;
  final String? initialPriority;

  AddTaskScreen({required this.onSave, this.initialTitle, this.initialPriority});


  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = TextEditingController();
  String _selectedPriority = 'Low';
  @override
  void initState(){
    super.initState();
    if (widget.initialTitle != null){
      _taskController.text = widget.initialTitle!;
    }
    if (widget.initialPriority != null){
      _selectedPriority = widget.initialPriority!;
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
            DropdownButton<String>(
              value: _selectedPriority,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPriority = newValue!;
                });
              },
              items: <String>['Low', 'Medium', 'High'].map <DropdownMenuItem<String>>((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
    
                  );
              }).toList(), 
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave(_taskController.text, _selectedPriority);
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
