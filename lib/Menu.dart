import 'dart:convert';
// this is for jsondecode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // for future return type functions we use Future
  var jsondata;
   Future getUserdata() async {
  final response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));

  if(response.statusCode == 200){
   jsondata = jsonDecode(response.body);
  }else{
    Text('error');
  }
  return jsondata["data"];
  // return only the data part in the given jsondecode
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        elevation: 0,
      ),
      body: Column(
             children: [
             FutureBuilder(
                future: getUserdata(),
                builder: (context , snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Text('loading');
                  }
                  else if( snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    List jsondata = snapshot.data as List;
                    // we have to use this command to access the information from the type list.

                    return Expanded(
                      child: ListView.builder(
                             itemCount: jsondata.length,
                              itemBuilder: (context, index){
                                return Padding(

                                    padding: EdgeInsets.all(10),
                                  child: Card(
                                    color: Colors.tealAccent,
                                    child: ListTile(
                                      onTap: () {},
                                       title: Text('${jsondata[index]["first_name"]}',
                                       style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontSize: 20,
                                       )),
                                      subtitle: Text('${jsondata[index]["email"]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),) ,
                                       leading: CircleAvatar(
                                         radius: 30,
                                        backgroundImage: NetworkImage(jsondata[index]["avatar"]),
                                      ),
                                    ),
                                  ),

                                );
                              }
                          ),
                    );
                    
                  }
                  else{
                  return Text("error");
                  }
                }
              )
        ],
      )

          );

  }
}

