import 'package:flutter/material.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/screens/product_detail_screen.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget{
  const ProductListScreen({Key?key}):super(key:key);

  @override
  State<ProductListScreen> createState()=>_ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen>{
 
 late ProductProvider _productProvider;

 @override
 void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
 
 
  @override
  Widget build (BuildContext context){
    return MasterScreenWidget(
      title_widget: Text("Product list"),
      child:Container(
        child: Column(children: [
          Text("Test"),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed:(){
              print("Login proceed");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=> const ProdutcDetailScreen(),
                ),
              );
            } , child: Text("Login"))
        ]),
      )
    );
     
    
  }
}