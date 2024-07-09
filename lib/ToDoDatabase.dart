import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'ToDoDAO.dart';
import 'ToDoItem.dart';

part 'ToDoDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ToDoItem])
abstract class ToDoDatabase extends FloorDatabase {

  ToDoDAO get getDao;  // Method 1: use variable for database CRUD
  //ToDoDao getDao();  // Method 2: use function such as getDao() for database CRUD
}


// flutter packages pub run build_runner build
// flutter packages pub run build_runner watch  // for update