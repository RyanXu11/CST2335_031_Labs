import 'ProfilePage.dart';
import 'repository.dart';
import 'toDoList.dart';
import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Lab for Week 6 By Ryan Xu'),
      routes: {
         // name        : Constructor for pages
        '/ProfilePage'  : (context) => ProfilePage(),
        '/Homepage' : (context) => MyHomePage(title:'Lab for Week 6 By Ryan Xu'),  // can't use '/'
        '/toDoList' : (context) => toDoList(),

      },
      initialRoute: '/Homepage' , //initial is the homepage, '/' can't be used
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  late TextEditingController _loginController; // for user name text, initialize later, but not null
  late TextEditingController _passwordController; // for password text, initialize later, but not null
  static const String correctPassword = 'QWERTY123'; // The correct password
  String _imagePath = 'images/question-mark.png';  // initialise the picture

  late EncryptedSharedPreferences storedData = EncryptedSharedPreferences();
  // final SharedPreferences storedData = await SharedPreferences.getInstance(); // await
  String fieldUserName = 'loginName';  // fieldname for 'UserName'
  String fieldPassword = 'Password';  // fieldname for 'Password'

  @override
  void initState() {  //loading page, Initialize the controllers
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    // storedData = EncryptedSharedPreferences();

    // loadSavedData();
    // repository.saveLoginName(_loginController.text);
    repository.loginName = _loginController.text;
    repository.loadData();
  }

  @override
  void dispose() {  // unloading page, dispose the controllers to free up resources
    //save DataRepository
    // var loginName = _loginController.value.text;
    // repository.saveLoginName(loginName);
    repository.saveData();

    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // function for buttonClicked
  void buttonClicked(){
    var loginName = _loginController.value.text;
    var userTyped2 = _passwordController.value.text;

    if (userTyped2 == correctPassword) {
      _imagePath = 'images/idea.png';
      // Navigate to ProfilePage
      // repository.saveLoginName(loginName);  // Method 1
      repository.loginName = _loginController.text; // Method 2, repository class
      // repository.saveData();    // Method 3, local saveData() function?
      Navigator.pushNamed(context,'/ProfilePage');
    } else {
      'images/stop.png';
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('UserName or Password are incorrect.'),
          actions: <Widget>[
            ElevatedButton(
              child:Text("Ok"),
              onPressed: () {
                // saveData();
                Navigator.pop(context);  // or Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  // function for button2Clicked
  void button2Clicked(){
    Navigator.pushNamed(context,'/toDoList');
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
                controller: _loginController,
                decoration: InputDecoration(
                  hintText:"Login",
                  border: OutlineInputBorder(),
                  labelText: "Login",
                )),
            TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                  labelText: "Password",
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(onPressed: buttonClicked,  // Lambda function, anonymous function
                    child: Text("Login")),
                // Spacer(flex: 1), // Add space between the buttons
                ElevatedButton(onPressed: button2Clicked,  // Lambda function, anonymous function
                    child: Text("toDoList Page")),
            ]),
            Image.asset(_imagePath, width:200.0, height:200.0),
          ],
        ),
      ),
    ),);
  }
}
