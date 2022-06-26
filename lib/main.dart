import 'package:flutter/material.dart';
import 'login.dart';
import 'Register.dart';
import 'Menu.dart';
import 'login.dart';


void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Login(),
     routes: {
             'login': (context) => Login(),
             'menu': (context) => Menu(),
              'register': (context) => Register()

},
  ));
}




//void main() {
  //runApp(MaterialApp(
    //debugShowCheckedModeBanner: false,
    //home: MyLogin(),
    //routes: {
     // 'register': (context) => MyRegister(),
      //'login': (context) => MyLogin(),
    //},
  //));
//}

