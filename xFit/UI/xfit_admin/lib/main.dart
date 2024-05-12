import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/screens/product_list_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>ProductProvider())
  ],
  child:  MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'xFit Login',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {

TextEditingController _usernameController=new TextEditingController();
TextEditingController _passwordController=new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), 
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                child:
                Text(
                  'xFit',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30,width: 30,), 
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                controller: _usernameController,
              ),
              SizedBox(height: 20), 
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                ),
                controller: _passwordController,
              ),
              SizedBox(height: 20), 
              ElevatedButton(
                onPressed: () {
                  var username=_usernameController.text;
                  var password=_passwordController.text;
                  print("login proceed $username $password");
                  Navigator.of(context).push(
                    MaterialPageRoute(builder:(context)=> const ProdcutListScreen(),)
                  );
                 
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10), 
              TextButton(
                onPressed: () {
                  
                },
                child: Text('Nemate korisnički račun? Napravite novi.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
