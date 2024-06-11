
//responsible for loading and saving itself
import 'dart:async';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class repository{

  static String firstName = ""; //initially it's empty string
  static String lastName = "";
  static String loginName = "";

  static void loadData()
  {
    //load your variables here
    var prefs = EncryptedSharedPreferences();
    prefs.getString("loginName").then( (endProduct) {loginName = endProduct;});
    //firstName =  await prefs.getString("firstName");
  }


  static void saveLoginName(loginName)
  {
    //save your variables
    var prefs = EncryptedSharedPreferences();
    if (loginName!= null && loginName.isNotEmpty){
      prefs.setString("loginName", loginName);
    }
  }

  static void saveData()
  {
    //save your variables
    var prefs = EncryptedSharedPreferences();
    if (loginName.isNotEmpty){
      prefs.setString("loginName", loginName);
    }
    if (firstName.isNotEmpty){
      prefs.setString("firstName", firstName);
    }
    if (lastName.isNotEmpty){
      prefs.setString("lastName", lastName);
    }
  }
}