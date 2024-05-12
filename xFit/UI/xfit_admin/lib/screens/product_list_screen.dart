import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class ProdcutListScreen extends   StatefulWidget{
  const ProdcutListScreen({Key? key}) : super(key: key);

  @override
  State<ProdcutListScreen> createState()=> _ProductListScreenState();
}

class _ProductListScreenState extends State<ProdcutListScreen> {
  
  late ProductProvider _productProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _productProvider=context.read<ProductProvider>();
  }

  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      title_widget: Text("Product list"),
      child: Container(
        child: Column(
          children: [
            Text("TEST"),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async{
                print("login proceed");
                //Navigator.of(context).pop();

                var data=await _productProvider.get();
                print("data: $data");

              },
              child: Text("Login")
            ),
            DataTable(
              columns: [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("Šifra")),
                DataColumn(label: Text("Naziv")),
              ],
              rows: [
                // Ovdje možete dodati redove tablice koristeći DataRow widget
                // Primjer:
                // DataRow(cells: [
                //   DataCell(Text('1')),
                //   DataCell(Text('Šifra1')),
                //   DataCell(Text('Naziv1')),
                // ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
