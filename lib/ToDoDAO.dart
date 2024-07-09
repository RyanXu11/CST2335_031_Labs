import 'package:floor/floor.dart';
import 'ToDoItem.dart';

@dao
abstract class ToDoDAO {
  @insert  // make it an insert function to generate
  Future<int> insertItem(ToDoItem itm);

  @Query('SELECT * FROM ToDoItem')  // query for all items
  Future<List<ToDoItem>> getAllItems();

  @delete // generate the deletion statement in code
  Future<int> deleteItem(ToDoItem itm);

  @update // update the table where id = itm.id
  Future<int> updateItem(ToDoItem itm);

}