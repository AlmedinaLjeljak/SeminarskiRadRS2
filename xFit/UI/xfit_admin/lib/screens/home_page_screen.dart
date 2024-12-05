import 'package:flutter/material.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class HomePageScreen extends StatefulWidget{
  const HomePageScreen({Key?key}):super(key:key);


@override
State<HomePageScreen> createState()=>_HomePageScreenState();

}

class _HomePageScreenState extends State<HomePageScreen>{
  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      title_widget: Text("Home page"),
      child: Text("TerminiScreenHehe"),
    );
  }
  
}