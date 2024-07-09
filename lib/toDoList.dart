import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ToDoDAO.dart';
import 'ToDoDatabase.dart';
import 'ToDoItem.dart';

class toDoList extends StatefulWidget {
  // final String loginName;
  // ProfilePage({Key? key, required this.loginName}) : super(key: key);

  //stateful means has variables
  @override
  State<toDoList> createState() => toDoListState(); // or {return OtherPageState()}
}

class toDoListState extends State<toDoList> {
  late TextEditingController _controller;
  // var listObjects = <String> [] ;
  var words = <ToDoItem>[];
  late ToDoDAO myDAO;

  @override
  void initState() {
    //loading page, Initialize the controllers
    super.initState();

    $FloorToDoDatabase.databaseBuilder('app_database.db').build().then( (database) async {
      myDAO = database.getDao; // now you can query;
      // List<ToDoItem> items = await myDAO.getAllItems();
      myDAO.getAllItems().then ( (listOfItems) {
        setState(() {
          words.addAll( listOfItems ); // add all items from listOfItems into words
        });
      });
    });  // read the database

    _controller = TextEditingController();
  }


  EdgeInsetsGeometry customPadding = EdgeInsets.fromLTRB(15, 15, 10, 10); // (left, Top, Right, Bottom)

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   var snackBar = SnackBar(
    //     content: Text('Welcome to toDoList!' ),
    //     duration: Duration(seconds: 7),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // });
    // returns how this looks on screen
    return Scaffold(
        // backgroundColor: Color(0xfef7ff),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("toDoList Page"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        setState(() {
                          var newItem = ToDoItem(ToDoItem.ID++, _controller.value.text);

                          words.add(newItem);  // put it on the screen

                          // add to the database:
                          myDAO.insertItem(newItem);

                          // clear the text
                          _controller.text = "";
                        });
                      },
                      child: Text("Add this")
                  ),
                  // SizedBox(width: 20),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10),),
                  Expanded(child: TextField(controller: _controller,
                    decoration: InputDecoration(
                        hintText: "Type here",
                        border: OutlineInputBorder(),
                        labelText: "Add message"
                    ),
                  ),
                  ),
                ],),
            if(words.isEmpty)
              Column(
                children: [
                  SizedBox(height: 20), // Add some space above the Text
                  Text('There are no items in the List.'),
                ],
              )
            else
              Expanded(  // makes the child as large as possible, taking up whole screen
                child:
                ListView.builder(
                  itemCount: words.length,// length of array as row number
                  itemBuilder: (context, rowNumber) {
                    return
                      GestureDetector(
                        child:
                        Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Text("Row number: ${rowNumber}  "), Text(words[rowNumber].toDoMesage)]
                        ),
                        onLongPress: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Deletion'),
                                content: Text('Are you sure you want to delete Row ${rowNumber}?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Yes'),
                                    onPressed: () {
                                      var snackBar = SnackBar(
                                        content: Text('Row: ${rowNumber} you tapped has been deleted.'),
                                        duration: Duration(seconds: 3),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      setState(() {
                                        var itm = words[rowNumber];
                                        myDAO.deleteItem(itm);
                                        words.removeAt(rowNumber); // it's gone after this line
                                      });
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                  }),
              ),
          ])
      )
    );
  }

}