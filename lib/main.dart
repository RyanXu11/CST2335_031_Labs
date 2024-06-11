import 'ProfilePage.dart';
import 'repository.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
      home: const MyHomePage(title: 'Lab 5 By Ryan Xu'),
      routes: {
         // name        : Constructor for pages
        '/ProfilePage'  : (context) => ProfilePage(),
        '/Homepage' : (context) => MyHomePage(title:'Lab 5 Homepage By Ryan Xu')  // can't use '/'
      },
      initialRoute: '/Homepage' , //initial is the homepage, '/' can't be used
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    repository.saveLoginName(_loginController.text);
    // repository.loginName = _loginController.text;
    repository.loadData();
  }

  // This function is used to load saved data
  void loadSavedData() async{
    // Retrieving username and password
    // final savedUserName = storedData.getString(fieldUserName);
    // if (savedUserName != null && savedUserName.isNotEmpty) {
    //     _loginController.text = savedUserName;
    //   }
    String message = 'Previous login name and passwords have been loaded.';
    String label = 'Clear the data?';
    int duration = 5;

    storedData.getString(fieldUserName).then((savedUserName) {
      if (savedUserName.isNotEmpty)  {
        _passwordController.text = savedUserName;
        showSnackBarClearData(context, message, label, duration);
      }
    });

    storedData.getString(fieldPassword).then((savedPassword) {
      if (savedPassword .isNotEmpty)  {
        _passwordController.text = savedPassword;
        showSnackBarClearData(context, message, label, duration);
      }
    });
  }


  // // This function is used to save data to storedData (encrypted_shared_preferences)
  // void saveData() {
  //   var userTyped1 = _loginController.value.text;
  //   var userTyped2 = _passwordController.value.text;
  //   if (userTyped1.isEmpty || userTyped2.isEmpty) {
  //     // Show a Snackbar with a warning
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Username or password cannot be empty.'))
  //     );
  //   } else {
  //     storedData.setString(fieldUserName, userTyped1).then((bool success){
  //       if (success) {
  //         print('save success!');
  //       } else {
  //         print('save fail');
  //       }
  //     }); // use then to avoid save failure
  //     storedData.setString(fieldPassword, userTyped2).then((bool success){
  //       if (success) { print('save success!');} else {print('save fail');}
  //     });
  //   }
  // }

  // This function is used to clear storedData and
  void clearData() {
    _loginController.text = '';
    _passwordController.text = '';
    storedData.remove(fieldUserName).then((bool success){
      if (success) { print('remove success!');} else {print('remove fail');}
    }); // use then to avoid save failure
    storedData.remove(fieldPassword);
  }

  // This function is used to show SnackBar
  void showSnackBarClearData(BuildContext context, String message, String label, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),  // Set duration
        action: SnackBarAction(
            label: label,
            onPressed: () {
              clearData();
            }
        ),
      ),
    );
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
      repository.saveLoginName(loginName);  // Method 1
      // repository.loginName = _loginController.text; // Method 2, repository class
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
            // ElevatedButton( //ElevatedButton or FilledButton or OutlineButton or TextButton
            //   child: Text("No"),
            //   onPressed: () {
            //     clearData();
            //     Navigator.pop(context);
            //   },
            //   // FilledButton(onPressed: (){ Navigator.pop(context);}, child: Text("Cancel")),
            //   // OutlinedButton(onPressed: (){ Navigator.pop(context);}, child: Text("Delete")),
            //   // Image.asset("images/algonquin.jpg", width:100, height: 100),
            // ),
          ],
        ),
      );


    }

    // setState(() {
    //   _imagePath = userTyped2 == correctPassword
    //       ? 'images/idea.png'
    //       : 'images/stop.png';
    // });



  }


  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

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
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
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
            ElevatedButton(onPressed: buttonClicked,  // Lambda function, anonymous function
                child: Text("Login")),
            Image.asset(_imagePath, width:200.0, height:200.0),
          ],
        ),
      ),
    ),);
  }
}
