
import 'package:floor/floor.dart';

@entity //variable names will be the column names
class ToDoItem{
  static int ID = 1;

  @primaryKey //unique ID numbers
  final int id;

  // final String message;

  final String toDoMesage; // columnNames

  ToDoItem( this.id, this.toDoMesage){
    // var i=0;
    // i++;
    if (id > ID) // from database
      ID = id + 1; //ID will always be 1 more than the biggest database id
  }

}