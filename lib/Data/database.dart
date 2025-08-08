import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List todolists = [];

  // reference our box
  final _myBox = Hive.box('MyBox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    todolists = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
    _myBox.put("TODOLIST", todolists);
  }

  // load the data from database
  void loadData() {
    var data = _myBox.get("TODOLIST");
    if (data != null) {
      todolists = List<List<dynamic>>.from(data);
    }
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", todolists);
  }
}