
import 'package:floor/floor.dart';

@entity //tells Floor what the table name is
class ToDoItem{

  static int ID = 1; //KEEP TRACK OF THE IDS
  final String itemName;


  @primaryKey
  final int id;

  ToDoItem(this.id, this.itemName){

      if(id >= ID) {
        ID = id+1;
      }
  }
}