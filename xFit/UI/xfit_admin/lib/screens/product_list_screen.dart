import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xfit_admin/widgets/master_screen.dart';


class ProdcutListScreen extends   StatefulWidget{
  const ProdcutListScreen({Key? key}) : super(key: key);

  @override
  State<ProdcutListScreen> createState()=> _ProductListScreenState();
}

class _ProductListScreenState extends State<ProdcutListScreen> {
  @override

  Widget build(BuildContext context){
    return MasterScreenWidget(
      child: Container(
      child: Column(children: [
           Text("TEST"),
           SizedBox(height:8,),
           ElevatedButton(onPressed: (){
            print("login proceed");
            Navigator.of(context).pop();

           }, child: Text("Login"))
      ]),)
      
    );
  }
 
}