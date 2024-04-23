import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_flutter_project/data/database.dart';
import 'package:my_flutter_project/utilities/dialog_box.dart';
import 'package:my_flutter_project/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState(); 
  
}
class _HomePageState  extends State<HomePage>{
  // referncin hive box
  final _mybox = Hive.box("thebox");
  ToDoDatabase db = ToDoDatabase();

  
  void initState(){
    // if this is frst time 
    if (_mybox.get("TODOLIST")== null){
      db.createInitialData();
    }else {
      db.loadData();
    }
    super.initState();
  }


  final _controller = TextEditingController();

  //list
  //check box gets tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoLIst[index][1] = !db.toDoLIst[index][1];
    });
    db.upateDatabase();

  }

void saveNewTask(){
  setState(() {
    db.toDoLIst.add([_controller.text, false]);
    _controller.clear();
  });
  Navigator.of(context).pop();
    db.upateDatabase();
}
  //new task
  void createNewTask(){
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
  //delete
  void deleteTask(int index){
    setState(() {
      db.toDoLIst.removeAt(index); 
    });
    db.upateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow, //.fromARGB(255, 215, 201, 45),//color for background of app
      appBar: AppBar(
        title: Text("Aggie's Do! "),
        
        
        elevation: 0, //text shadows
        backgroundColor: Colors.blue,   //.fromARGB(255, 10, 38, 180),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask ,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: db.toDoLIst.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoLIst[index] [0], 
          taskCompleted: db.toDoLIst[index][1], 
          onChanged: (value)  => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}