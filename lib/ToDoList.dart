import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ToDoDAO.dart';
import 'ToDoDatabase.dart';
import 'ToDoItem.dart';

class ToDoList extends StatefulWidget {
  // final String loginName;
  // ProfilePage({Key? key, required this.loginName}) : super(key: key);

  //stateful means has variables
  @override
  State<ToDoList> createState() => ToDoListState(); // or {return OtherPageState()}
}

class ToDoListState extends State<ToDoList> {
  late TextEditingController _controller;
  var words = <ToDoItem>[];
  late ToDoDAO myDAO;

  String? selectedItem = null; // Either a string or null
  int selectedItemId = 0;
  int rowNum = 0;

  @override
  void initState() {
    //loading page, Initialize the controllers
    super.initState();

    $FloorToDoDatabase.databaseBuilder('app_database.db').build().then( (database) async {
      myDAO = database.getDao; // now you can query;
      myDAO.getAllItems().then ( (listOfItems) {
        setState(() {
          words.addAll( listOfItems ); // add all items from listOfItems into words
        });
      });
    });  // read the database

    _controller = TextEditingController();
  }

  Widget ToDoList() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      var newItem = ToDoItem(ToDoItem.ID++, _controller.value.text);
                      words.add(newItem);  // put it on the screen
                      myDAO.insertItem(newItem);   // add to the database:
                      _controller.clear();      // clear the text
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
                        onTap:() {
                          setState(() {
                            selectedItem = words[rowNumber].toDoMesage;  // make it selected
                            selectedItemId = words[rowNumber].id;
                            rowNum = rowNumber;
                          });
                        },
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
                                      DeleteItem(rowNumber);
                                      Navigator.of(context).pop(); // Close the dialog},
                                    }),
                                ],
                              );
                            },
                          );
                        },
                      );
                  }),
            ),
        ]);
  }

  Widget DetailsPage(){
    if (selectedItem == null)
      return Text("");  // so this compiles, nothing shows
    else
      return Column(children: [
        Text("Selected item ${rowNum}: ItemName = ${selectedItem}, databaseId = ${selectedItemId}"),
        OutlinedButton(
         onPressed: (){
            setState(() {
              DeleteItem(rowNum);
              selectedItem = null;
            });
        }, child: Text("Delete")),
      ]);
  }

  Widget responsiveLayout(){
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    //landscape or tablet layout
    if ((width>height) && (width > 720)) //screen is wide enough (1920 * 1024
      //room to put list on left side:
        {
      return Row(children: [
        Expanded(flex: 1, child: ToDoList()),  // takes 1/(1+2) of available width
        Expanded(flex: 2, child: DetailsPage()),    // takes 2/(1+2) of available width
      ]);
    }
    else //portrait
        {
      if(selectedItem == null)
        return ToDoList();
      else
        return DetailsPage();
    }
  }


  EdgeInsetsGeometry customPadding = EdgeInsets.fromLTRB(15, 15, 10, 10); // (left, Top, Right, Bottom)

  void DeleteItem(rowNumber) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xfef7ff),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("toDoList"),
          actions: [
            OutlinedButton(onPressed: (){
              setState(() {selectedItem = null; });
            }, child: Text("Back")),
          ]
        ),
        body: responsiveLayout(),
    );
  }

}