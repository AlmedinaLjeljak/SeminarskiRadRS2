import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/providers/proizvod_provajder.dart';
import 'package:xfit_admin/screens/product_list_screen.dart';
import 'package:xfit_admin/utils/util.dart';

void main(){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>ProizvodProvajder())
  ],
  child: const MyMaterialApp(),
  ));
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
      home: LoginPage(),
    );
  }
}



class LoginPage extends StatelessWidget{
    LoginPage({Key?key}):super(key:key);

TextEditingController _usernameController=new TextEditingController();
TextEditingController _passwordController=new TextEditingController();
late ProizvodProvajder _productProvider;

  @override
  Widget build(BuildContext context){
    _productProvider=context.read<ProizvodProvajder>();
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
                  //Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo0MF_VELfZYivdtS2KnjBYE_kWhp_V2IbPiCKxNs90g&s",height: 100,width: 100,),
                  Image.asset("assets/images/logo1.png",height: 100,width: 100,),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.email)
                    ),
                    controller: _usernameController,
                  ),
                  SizedBox(height: 8,),
                  TextField(
                    decoration: InputDecoration( 
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password)
                    ),
                    controller: _passwordController,
                  ),
                  SizedBox(height: 8,),
                  ElevatedButton(onPressed: ()async{
                   
                    var username=_usernameController.text;
                    var password=_passwordController.text;
                    _passwordController.text=username;
                     print("Login proceed $username $password");
                    
                    //Authorization.username=username;
                    //Authorization.password=password;

                    

                   // try {
                      //await _productProvider.get();

                            Navigator.of(context).push(
                            MaterialPageRoute(
                            builder:(context)=>const ProductListScreen(), ),
                         );
                    //} on Exception catch (e) {
                      //showDialog(context: context,
                       //builder: (BuildContext context)=>AlertDialog(
                        //title: Text("Error"),
                        //content: Text(e.toString()),
                        //actions: [
                        //TextButton(onPressed: ()=>Navigator.pop(context), child: Text("OK"))
                       // ],
                       //));

                              //  }
                  }, child: Text("Login"))
                ]),
              ),
            ),
          ),)
    );
  }
}


