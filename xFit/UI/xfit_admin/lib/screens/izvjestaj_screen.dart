import 'package:flutter/material.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class IzvjestajScreen extends StatefulWidget{
  const IzvjestajScreen({Key?key}):super(key:key);


@override
State<IzvjestajScreen> createState()=>_IzvjestajScreenState();

}

class _IzvjestajScreenState extends State<IzvjestajScreen>{
  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      child: Text("Izvjestaj"),
    );
  }
}