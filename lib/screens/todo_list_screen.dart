import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';
import '../helper/task_provider.dart';

class TodoListScreen extends StatelessWidget {
  void _addTask(BuildContext context) async {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(
          onSave: (newTaskTitle, newTaskPriority) {
            final newTask = Task(title: newTaskTitle, priority: newTaskPriority);
            provider.addTask(newTask);
          },
        ),
      ),
    );
  }

  void _deleteTask(BuildContext context, Task task, int index) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    provider.deleteTask(task);

    // Show the SnackBar with the delete action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task deleted"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            provider.addTask(task); // Re-add the task if UNDO is clicked
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: provider.tasks.length,
        itemBuilder: (context, index) {
          final task = provider.tasks[index];
          return TaskCard(
            task: task,
            onCompleted: (bool? value) => provider.toggleTaskCompletion(task),
            onDelete: () => _deleteTask(context, task, index),
            onEdit: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(
                    initialTitle: task.title,
                    initialPriority: task.priority,
                    onSave: (updatedTitle, updatedPriority) {
                      task.title = updatedTitle;
                      task.priority = updatedPriority;
                      provider.updateTask(task);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        child: Icon(Icons.add),
        tooltip: 'Add Task',
      ),
    );
  }
}
