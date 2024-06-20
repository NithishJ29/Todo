import 'package:flutter/material.dart';
import 'package:app2/models/task.dart';
import 'package:app2/widgets/task_title.dart';
import 'package:app2/widgets/task_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void editTask(Task task, int index) {
    setState(() {
      tasks[index] = task;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
            onEdit: () => _showTaskForm(tasks[index], index),
            onDelete: () => deleteTask(index),
            onToggleCompletion: () => toggleTaskCompletion(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskForm(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showTaskForm([Task? task, int? index]) {
    showDialog(
      context: context,
      builder: (context) {
        return TaskForm(
          task: task,
          onSave: (newTask) {
            if (index == null) {
              addTask(newTask);
            } else {
              editTask(newTask, index!);
            }
          },
        );
      },
    );
  }
}
