import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab3/repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatefulWidget {
  // final String loginName;
  // ProfilePage({Key? key, required this.loginName}) : super(key: key);

  //stateful means has variables
  @override
  State<ProfilePage> createState() => ProfilePageState(); // or {return OtherPageState()}
}

class ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController; // for user name text, initialize later, but not null
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    //loading page, Initialize the controllers
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();

    // Show Snackbar
    // var snackBar = SnackBar(
    //   content: Text('Welcome Back' + DataRepository.loginName),
    //   duration: Duration(seconds: 10), // Adjust duration as needed
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  EdgeInsetsGeometry customPadding =
      EdgeInsets.fromLTRB(15, 10, 15, 10); // (left, Top, Right, Bottom)

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var snackBar = SnackBar(
        content: Text('Welcome Back ' + DataRepository.loginName + '!'),
        duration: Duration(seconds: 7),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    // returns how this looks on screen
    return Scaffold(
      // backgroundColor: Color(0xfef7ff),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Profile Page"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: customPadding, //
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: "First Name",
                    border: OutlineInputBorder(),
                    // labelText: "Login",
                  ),
                ),
              ),
              Padding(
                padding: customPadding,
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    border: OutlineInputBorder(),
                    // labelText: "Login",
                  ),
                ),
              ),
              Padding(
                padding: customPadding,
                child: Row(children: [
                  Flexible(
                    flex: 10,
                    child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          border: OutlineInputBorder(),
                        )
                        // labelText: "Login",
                        ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        _makePhoneCall('+1-613-297-7277');
                      },
                      icon: Icon(Icons.phone),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        _sendMessage('6132977277');
                      },
                      icon: Icon(Icons.message),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: customPadding,
                child: Row(children: [
                  Flexible(
                    flex: 15,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        border: OutlineInputBorder(),
                        // labelText: "Login",
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        _sendEmail('xu000310@algonquinlive.com');
                      },
                      icon: Icon(Icons.email),
                    ),
                  ),
                ]),
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // go back page one
                  },
                  child: Text("Welcome "  + DataRepository.loginName),
              ),
            ],),
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final String url = 'tel:$phoneNumber';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching phone call: $e');
      var snackBar = SnackBar(content: Text('Failed to make phone call.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _sendMessage(String phoneNumber) async {
    final String url = 'sms:$phoneNumber';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching message: $e');
      var snackBar = SnackBar(content: Text('Failed to send message.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _sendEmail(String email) async {
    final emailFormat = Uri(
      scheme: 'mailto',
      path: email,
    );
    try {
      await launchUrl(emailFormat);
    } catch (e) {
      print('Error launching email: $e');
      var snackBar = SnackBar(content: Text('Failed to send email.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
