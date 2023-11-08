import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // Reference the hive box
  final _myBox = Hive.box('mybox');

  // Run this method if this is the first time ever opening this app
  void createInitialData() {
    toDoList = [
      ['Make Tutorial', false],
      ['Do exercise', false],
    ];
  }

  // Load data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  // Update database
  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
