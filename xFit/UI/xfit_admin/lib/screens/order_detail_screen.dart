import 'package:flutter/material.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class OrderDetailScreen extends StatefulWidget{
  const OrderDetailScreen({Key?key}):super(key:key);


@override
State<OrderDetailScreen> createState()=>_OrderDetailScreenState();

}

class _OrderDetailScreenState extends State<OrderDetailScreen>{
  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      child: Text("Izvjestaj"),
    );
  }
}