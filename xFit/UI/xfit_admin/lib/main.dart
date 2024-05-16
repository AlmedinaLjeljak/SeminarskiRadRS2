import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyMaterialApp());
}
class MyApp extends StatelessWidget{
  const MyApp({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',

      theme:ThemeData(
        primarySwatch: Colors.blue
      ),
      home:Text("Welcome"),
    );
  }
}

class MyMaterialApp extends StatelessWidget{
  const MyMaterialApp({Key?key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'RS II Material app',
      theme:ThemeData(primarySwatch: Colors.blue),
      home:const LoginPage(),
    );
  }
}



class LoginPage extends StatelessWidget{
  const LoginPage({Key?key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        ),
        body:Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400,maxHeight: 400),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo0MF_VELfZYivdtS2KnjBYE_kWhp_V2IbPiCKxNs90g&s",height: 100,width: 100,),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.email)
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextField(
                    decoration: InputDecoration( 
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password)
                    ),
                  ),
                  SizedBox(height: 8,),
                  ElevatedButton(onPressed: (){
                    print("Login proceed");
                  }, child: Text("Login"))
                ]),
              ),
            ),
          ),)
    );
  }
}


