import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../components/dialog_box.dart';
import '../components/to_do_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create text controller
  final _controller = TextEditingController();

  // List of todo tasks
  List toDoList = [
    ['Make Tutorial', false],
    ['Do Exercise', false],
  ];

  // Checkbox was tapped
  void checkboxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  // Save new tassk
  void saveNewTask() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        toDoList.add([_controller.text, false]);
      }
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  // Create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Delete a task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  // Share app function
  void sharePressed() {
    String message =
        'Check out this new app, ToDo, that assists you in organizing your daily tasks.'
        ' Contact developer: rapcedy@gmail.com';
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'TO DO',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {
                sharePressed();
              },
              child: const Icon(
                Icons.share,
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.cyan[300],
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: toDoList[index][0],
                  taskCompleted: toDoList[index][1],
                  onChanged: (value) => checkboxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
        ],
      ),
    );
  }
}
