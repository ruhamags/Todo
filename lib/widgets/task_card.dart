import 'package:flutter/material.dart';

import '../models/task.dart';
// import '../models/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?>? onCompleted;

  TaskCard({required this.task, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: onCompleted,
        ),
      ),
    );
  }
}
