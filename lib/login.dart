import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Login(),
));

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/APP1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40, left: 30),
              child: Text('WELCOME BACK',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.indigo[900],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailcontroller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey[100],
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),

                          SizedBox(height: 15),

                          TextField(
                            controller: passwordcontroller,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey[100],
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(height:60),


                         RaisedButton.icon(
                           color: Colors.pink,
                            onPressed: () {
                             login();
                            },

                            icon: Icon(Icons.login,
                            color: Colors.white),
                           label: Text('Login',
                           style: TextStyle(
                             color: Colors.white,
                           ),),
                      ),
                          SizedBox(height: 45),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'register');
                                  },
                                  child: Text(
                                    'New User? Click to SignUp',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                      color: Colors.red,
                                    ),
                                  )
                              ),

                            ],
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   void login() async{
    if(emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty){
       var response = await http.post(Uri.parse('https://reqres.in/api/login'),
           body: ({
         "email": emailcontroller.text,
         "password": passwordcontroller.text
       }));
        if(response.statusCode == 200) {
         final note = jsonDecode(response.body);
         print("Token : ${note['token']}");
          ScaffoldMessenger.of(context).
         showSnackBar(SnackBar(content: Text(""
              "Logged In Successfully")));
         Navigator.pushNamed(context, 'menu');
       }else{
         ScaffoldMessenger.of(context).
         showSnackBar(SnackBar(content: Text("Invalid Credentials")));
       }

    }
    else{
      ScaffoldMessenger.of(context).
      showSnackBar(SnackBar(content: Text('Fill in the details')));
    }
  }
}



