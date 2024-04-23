import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{
  List toDoLIst = [];
  //reference box
  final _mybox = Hive.box("thebox");

  //runs method if frist time using app ever
  void createInitialData(){
    toDoLIst = [
      ["Do homework", false],
      ["Study", false],
    ];
  }
  // loading data
  void loadData(){
    toDoLIst = _mybox.get("TODOLIST");
  }

  //update data
  void upateDatabase(){
    _mybox.put("TODOLIST", toDoLIst);
  }
}

