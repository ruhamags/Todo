import 'package:flutter/material.dart';
// import '../models/models/task.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = []; // The list should hold Task objects

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

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          onCompleted: (bool? value) {
            setState(() {
              task.isCompleted = value ?? false;
            });
          },
          onDelete: () {
            setState(() {
              tasks.removeAt(index);
            }
            );
          },
          onEdit:(){
              _editTask(task, index);
            },
          
        );
        
      },
    );
  }

  void _addTask() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(
          onSave: (newTaskTitle) {
            setState(() {
              tasks.add(Task(title: newTaskTitle)); // Add Task object
            });
          },
        ),

      ),
    );
  }
  void _editTask(Task task, int index) async{
  final result =  await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddTaskScreen(
        onSave: (updatedTaskTitle){
          setState(() {
            tasks[index].title = updatedTaskTitle;
          });
        }))
    );
  }
}
