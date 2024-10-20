import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List todolist = [];

  final _myBox = Hive.box('myBox');
  void creatInitialData() {
    todolist = [
      ["make brakfast", false],
      ["study", false],
    ];
  }

  void loadData() {
    todolist = _myBox.get("ToDoList");
  }

  void updateDataBase() {
    _myBox.put("ToDoList", todolist);
  }
}
