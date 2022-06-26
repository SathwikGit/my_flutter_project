import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Register(),
));

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final name_controller = TextEditingController();
  final id_controller = TextEditingController();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/APP2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40, left: 30),
              child: Text('\   REGISTRATION \n        PORTAL',
                     style: TextStyle(
                     fontSize: 40,
                     fontWeight: FontWeight.bold,
                     color: Colors.black87,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                     margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: name_controller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey[100],
                                filled: true,
                                hintText: "Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),

                          SizedBox(height: 15),

                          TextField(
                            controller: id_controller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey[100],
                                filled: true,
                                hintText: "ID Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: email_controller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey[100],
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),

                          SizedBox(height:15),

                          TextField(
                            controller: password_controller,
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
                       SizedBox(height: 60),

                          RaisedButton.icon(
                            color: Colors.black,
                            onPressed: () {
                              Signup();
                            },

                            icon: Icon(Icons.login,
                                color: Colors.white),
                            label: Text('SignUp',
                              style: TextStyle(
                                color: Colors.white,
                              ),),
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
  void Signup() async{
    if(email_controller.text.isNotEmpty && password_controller.text.isNotEmpty && name_controller.text.isNotEmpty && id_controller.text.isNotEmpty){
      var response = await http.post(Uri.parse('https://reqres.in/api/register'),
          body: ({
            "email": email_controller.text,
            "password": password_controller.text,
          }));
      if(response.statusCode == 200) {
        final note = jsonDecode(response.body);
        print("Token : ${note['token']}");
        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(content: Text("Account Created Successfully")));
        Navigator.pushNamed(context, 'menu');
      }else{
        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }

    }
    else{
      ScaffoldMessenger.of(context).
      showSnackBar(SnackBar(content: Text('Fill in the Details')));
    }
  }
}


