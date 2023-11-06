import 'package:flutter/material.dart';
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
      toDoList.add([_controller.text, false]);
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
            GestureDetector(
              child: const Text(
                'TO DO',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(Icons.share)
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
                );
              },
            ),
          ),
          SizedBox(
            height: height * 0.02,
          )
        ],
      ),
    );
  }
}
