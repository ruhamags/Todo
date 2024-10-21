import 'package:flutter/material.dart';

import '../models/task.dart';
// import '../models/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?>? onCompleted;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  TaskCard({required this.task, required this.onCompleted, required this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        trailing: Row (
          mainAxisSize: MainAxisSize.min,
          children: [
          Checkbox(
          value: task.isCompleted,
          onChanged: onCompleted,
        ),
        IconButton(
          onPressed:onDelete , 
          icon: Icon(Icons.delete)
          ),
          IconButton(
          onPressed:onEdit , 
          icon: Icon(Icons.edit)
          )
          ]
        ),
      ),
      
    );
  }
}
