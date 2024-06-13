import 'package:flutter/material.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class OrdersScreen extends StatefulWidget{
  const OrdersScreen({Key?key}):super(key:key);


@override
State<OrdersScreen> createState()=>_OrdersScreenState();

}

class _OrdersScreenState extends State<OrdersScreen>{
  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      child: Text("OrdersScreenTest123"),
    );
  }
}