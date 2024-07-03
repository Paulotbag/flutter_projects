//code for lab 6
import 'package:flutter/material.dart';

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
  List<String> toDoList = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addToDoItem() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        toDoList.add(_controller.text);
        _controller.clear();
      }
    });
  }

  void _removeToDoItem(int index) {
    setState(() {
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
                  onPressed: _addToDoItem,
                  child: const Text("Add"),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Enter a todo item",
                        border: OutlineInputBorder(),
                        //labelText: "To Do",
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
                            Text("Row number: $index"),
                            Text(toDoList[index]),
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


