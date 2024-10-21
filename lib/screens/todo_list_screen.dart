import 'package:flutter/material.dart';
import '../Helper/task_database.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = []; // The list of tasks

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks from the database when the screen loads
  }

Future<void> _loadTasks() async {
  final taskList = await TaskDatabase.instance.getTasks(); // Fetch tasks from the database
  print("Loaded tasks: ${taskList.length}"); // Debugging line to check task retrieval

  setState(() {
    tasks = taskList; // Populate the tasks list from the database
  });
}


  // Add Task function
void _addTask() async {
  final result = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => AddTaskScreen(
        onSave: (newTaskTitle, newTaskPriority) async {
          final newTask = Task(title: newTaskTitle, priority: newTaskPriority);
          final id = await TaskDatabase.instance.createTask(newTask); // Make sure this is awaited
          newTask.id = id; // Assign the ID returned from the database

          setState(() {
            tasks.add(newTask); // Add task to the in-memory list
          });
        },
      ),
    ),
  );
}

  // Edit Task function
  void _editTask(int index) async {
    final task = tasks[index];
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(
          initialTitle: task.title,
          initialPriority: task.priority,
          onSave: (updatedTaskTitle, updatedTaskPriority) {
            setState(() {
              tasks[index].title = updatedTaskTitle;
              tasks[index].priority = updatedTaskPriority;
            });
            TaskDatabase.instance.updateTask(tasks[index]); // Update the task in the database
          },
        ),
      ),
    );
  }

  // Function to toggle task completion
  void _toggleTaskCompletion(int index, bool? isCompleted) {
    setState(() {
      tasks[index].isCompleted = isCompleted ?? false;
    });
    TaskDatabase.instance.updateTask(tasks[index]); // Update task completion in the database
  }

  // Function to delete a task
void _deleteTask(int index) {
  final task = tasks[index];
  setState(() {
    tasks.removeAt(index); // Remove the task from the list
  });
  TaskDatabase.instance.deleteTask(task.id!); // Remove the task from the database

  // Show the SnackBar with the correct context using ScaffoldMessenger
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task deleted"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              tasks.insert(index, task); // Reinsert the task
            });
            TaskDatabase.instance.createTask(task); // Reinsert the task into the database
          },
        ),
      ),
    );
  });
}


  // Build the list of tasks
  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          onCompleted: (bool? value) => _toggleTaskCompletion(index, value),
          onDelete: () => _deleteTask(index),
          onEdit: () => _editTask(index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
        tooltip: 'Add Task',
      ),
    );
  }
}
