import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:cached_network_image/cached_network_image.dart';

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
      title: 'CST2335_031 Lab3 Demo',
      theme: ThemeData(
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CST2335_031 Lab3 Demo'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('BROWSE CATEGORIES',
              style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const Text("Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                style: TextStyle(fontSize: 13.0, color: Colors.black)
            ),
            const Text('BY MEAT', style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold)
            ),
            Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Stack (
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/Beef.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("BEEF", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),)
                ]),
                Stack (
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/Chicken.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("CHICKEN", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),)
                ]),
                Stack (
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/Pork.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("PORK", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),)
                ]),
                Stack (
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/Seafood.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("SEAFOOD", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),)
                ]),
              ],
            ),
            const Text('BY COURSE', style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold)
            ),
            Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Stack (
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/MainDishes.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("Main Dishes", style: TextStyle(fontSize: 15.0, color: Colors.blue, fontWeight: FontWeight.bold),)
                    ]),
                Stack (
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/Salad.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("Salad Recipes", style: TextStyle(fontSize: 15.0, color: Colors.blue, fontWeight: FontWeight.bold),)
                    ]),
                Stack (
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/SideDishes.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("Side Dishes", style: TextStyle(fontSize: 15.0, color: Colors.blue, fontWeight: FontWeight.bold),)
                    ]),
                Stack (
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/Crockpot.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("Crockpot", style: TextStyle(fontSize: 15.0, color: Colors.blue, fontWeight: FontWeight.bold),)
                    ]),
              ],
            ),
            const Text('BY DESSERT', style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold)
            ),
            Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/IceCream.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("Ice Cream", style: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),)
                    ]),
                Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/Brownies.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("Brownies", style: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),)
                    ]),
                Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/Pies.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text("Pies", style: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),)
                    ]),
                Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(child: Image.asset("images/Cookies.jpg", width: 100, height: 100, fit: BoxFit.cover),),
                      Text( "Cookies", style: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),)
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
