import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/Data/database.dart';
import 'package:notesapp/components/dialogueBox.dart';
import 'package:notesapp/components/todoTiles.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('MyBox');
  ToDoDataBase db = ToDoDataBase();
  final taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  //add to list function
  void addToList() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        db.todolists.add([taskController.text, false]);
        taskController.clear();
      });
      db.updateDataBase();
      Navigator.pop(context);
    }
  }

  void DisplayDial() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          taskController: taskController,
          onSave: addToList,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todolists[index][1] = value;
    });
    db.updateDataBase();
  }

  void delFun(int index) {
    setState(() {
      db.todolists.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        elevation: 0,
        title: Center(child: Text(' TO DO ')),
      ),
      body: ListView.builder(
        itemCount: db.todolists.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskname: db.todolists[index][0],
            taskCompleted: db.todolists[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => delFun(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: DisplayDial,
        backgroundColor: Colors.deepPurple[500],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}


