import 'package:flutter/material.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class TerminiScreen extends StatefulWidget{
  const TerminiScreen({Key?key}):super(key:key);


@override
State<TerminiScreen> createState()=>_TerminiScreenState();

}

class _TerminiScreenState extends State<TerminiScreen>{
  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      title_widget: Text("Appointments"),
      child: Text("TerminiScreenHehe"),
    );
  }
  
}




  

