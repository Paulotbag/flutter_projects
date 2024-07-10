//code for lab 8
import 'package:flutter/material.dart';
import 'package:test_flutter/ToDoDatabase.dart';


import 'ToDoDAO.dart';
import 'ToDoItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'To Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  late ToDoDAO myDAO;
  List<ToDoItem> toDoList = []; //the list of String in our ToDopage became list of ToDoItem



  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    final database = await $FloorToDoDatabase.databaseBuilder('myDatabaseFile.db').build();
    myDAO = database.getDAO; // Initialize myDAO once database is ready

    // Retrieve all items from the database
    final listOfAllItems = await myDAO.getAllToDoItems();
    setState(() {
      toDoList.addAll(listOfAllItems);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addToDoItem() {
    setState(() {
      var newItem = ToDoItem(ToDoItem.ID++, _controller.text);
      if (_controller.text.isNotEmpty) {
        toDoList.add(newItem);
        _controller.clear();
      }
      myDAO.insertToDo(newItem).then((_) {

      });
    });
  }

  void _removeToDoItem(int index) {
    setState(() {
      //also delete from DAO
      myDAO.deleteToDo(toDoList[index]);

      //delete from list variable
      toDoList.removeAt(index);


    });
  }

  void _showDeleteDialog(int index) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete To Do Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _removeToDoItem(index);
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: const Text("Add"),
                  onPressed: _addToDoItem,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Enter a todo item",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: toDoList.isEmpty ?
            const Center(
              child: Text("There are no items in the list"),
            )
                :ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => _showDeleteDialog(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Row number: ${toDoList[index].id}"),
                        Text(toDoList[index].itemName),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


