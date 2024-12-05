import 'package:flutter/material.dart';
import 'package:xfit_admin/main.dart';
import 'package:xfit_admin/screens/home_page_screen.dart';
import 'package:xfit_admin/screens/izvjestaj_screen.dart';
import 'package:xfit_admin/screens/novost_screen.dart';
import 'package:xfit_admin/screens/orders_screen.dart';
import 'package:xfit_admin/screens/product_detail_screen.dart';
import 'package:xfit_admin/screens/product_list_screen.dart';
import 'package:xfit_admin/screens/termini_screen.dart';

class MasterScreenWidget extends StatefulWidget{
  Widget? child;
  String?title;
  Widget? title_widget;
  MasterScreenWidget({this.child,this.title_widget,this.title,Key?key}):super(key: key);


  @override
  State<MasterScreenWidget> createState()=> _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:widget.title_widget?? Text(widget.title??""),
        /*actions:[
          TextButton.icon(
              onPressed: (() {
                if (!ModalRoute.of(context)!.isFirst) {
                  Navigator.pop(context,
                      'reload2');
                }
              }),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              label: Text(
                "Back",
                style: const TextStyle(color: Colors.white),
              )),

        ],*/
      ),
      drawer: Drawer(
        child:Container(
          color: Color.fromARGB(255, 167, 230, 237),
        
        child:ListView(
         children: [
         ListTile(
            title:Text("Back"),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>LoginPage(),),
              );
             
              
              
            },
          ),
          ListTile(
            title:Text("Home"),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(context)=> HomePageScreen(),
                ),
              );
            },
          ),
          ListTile(
            title:Text("Products"),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(context)=>const ProductListScreen(),
                ),
              );
            },
          ),
          ListTile(
            title:Text("Details"),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(context)=> ProductDetailScreen(),
                ),
              );
            },
          ),
            ListTile(
            title:Text("Orders"),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(context)=>const OrdersScreen(),
                ),
              );
            },
          ),
           ListTile(
            title:Text("Appointments"),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(context)=> TerminiScreen(),
                ),
              );
            },
          ),
           ListTile(
            title:Text("Reports"),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(context)=> IzvjestajScreen(),
                ),
              );
            },
          ),
         ],
          
        ),
      )),
      body: widget.child!,
    );
  }
}

