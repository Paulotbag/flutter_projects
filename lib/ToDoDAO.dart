
import 'package:floor/floor.dart';
import 'package:test_flutter/ToDoItem.dart';

@dao //tells compiler this is a Dao object
abstract class ToDoDAO{ //always abstract

  @insert                 //ToDoItem is an entity
  Future<void>insertToDo( ToDoItem itm); //this specify that this is an insert statement

  @delete //translated delete statement from ToDoItem where id = ...
  Future<int>deleteToDo(ToDoItem itm); //converts into a deletion statement in SQL

  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> getAllToDoItems(); //asynchronous - looks like query is always asynchronous

  @update //translated to update table ToDoItem where id = ...
  Future<int> updateToDoItem(ToDoItem itm); //pass an updated item with same id

  
}