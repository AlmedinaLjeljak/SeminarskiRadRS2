import 'package:flutter/material.dart';
import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class ProdutcDetailScreen extends StatefulWidget{
Product?product;
 ProdutcDetailScreen({Key?key}):super(key: key);

  @override
  State<ProdutcDetailScreen> createState()=> _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProdutcDetailScreen>{
@override
Widget build(BuildContext context){
  return MasterScreenWidget(
    child: Text("Details"),
    title:this.widget.product?.naziv?? "Product details",
  );
}
}