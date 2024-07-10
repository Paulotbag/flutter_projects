import 'package:floor/floor.dart';
import 'package:test_flutter/ToDoDAO.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:test_flutter/ToDoItem.dart';
import 'dart:async';

part 'ToDoDatabase.g.dart';
                                  //@entity
@Database( version: 1 , entities: [ToDoItem])  //the version number will drop the table and create a new one
abstract class ToDoDatabase extends FloorDatabase{
  //we need and just one function to get DAO object to interact with this database
  ToDoDAO get getDAO; //NO ()
}