// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/dataBase.dart';
import 'package:todolist/util/dialog.dart';
import 'package:todolist/util/todotile.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final _myBox = Hive.box('myBox');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("ToDoList") == null) {
      db.creatInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.updateDataBase();
  }

  void saveNew() {
    setState(() {
      db.todolist.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void newTask() {
    showDialog(
        context: context,
        builder: (context) {
          return dialogbox(
            controller: _controller,
            onSave: saveNew,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todolist.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        actions: [
          MaterialButton(
              child: Text(
                'Check all',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                int i = 0;
                setState(() {
                  while (i < db.todolist.length) {
                    if (db.todolist[i][1] == false) {
                      db.todolist[i][1] = true;
                    }
                    i++;
                  }
                  db.updateDataBase();
                });
              }),
          MaterialButton(
              child: Text(
                'Uncheck all',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                int i = 0;
                setState(() {
                  while (i < db.todolist.length) {
                    if (db.todolist[i][1] == true) {
                      db.todolist[i][1] = false;
                    }
                    i++;
                  }
                  db.updateDataBase();
                });
              })
        ],
        title: Text("To Do"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: newTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todolist.length,
        itemBuilder: (context, index) {
          return todo(
            taskName: db.todolist[index][0],
            taskdone: db.todolist[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
