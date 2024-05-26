import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/screens/product_detail_screen.dart';
import 'package:xfit_admin/utils/util.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget{
  const ProductListScreen({Key?key}):super(key:key);

  @override
  State<ProductListScreen> createState()=>_ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen>{
 
 late ProductProvider _productProvider;
SearchResult<Product>? result;
TextEditingController _ftsController=new TextEditingController();
TextEditingController _sifraController=new TextEditingController();


 @override
 void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _productProvider=context.read<ProductProvider>();
  }
 
 
  @override
  Widget build (BuildContext context){
    return MasterScreenWidget(
      title_widget: Text("Product list"),
      child:Container(
        child: Column(children: [
          _buildSearch(),
          _buildDataListView()
        ]),
      ),
    );
     
    
  }

Widget _buildSearch(){
return Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
     children:[ 
      Expanded(child: TextField(
        decoration: InputDecoration(
          labelText: "Naziv ili sifra"),
          controller: _ftsController,
          ),
          ),
            SizedBox(
              width: 8,
            ),
            Expanded(child: TextField(
        decoration: InputDecoration(
          labelText: "Sifra"),
          controller: _sifraController,
          ),
          ),
            ElevatedButton(
              onPressed:()async{
                print("Login proceed");
                
                var data=await _productProvider.get(filter: {
                  'fts':_ftsController.text,
                  'sifra':_sifraController.text
                });
  
                setState(() {
                  result=data;
                });
                //print("data: ${data.result[0].naziv}");
              } , child: Text("Pretraga")),
     ]        
    ),
);
}
Widget _buildDataListView() {
    return Expanded(child:SingleChildScrollView(child: 
          DataTable(columns: [
            const DataColumn(label: const Expanded(
              child:const Text(
                'ID',
                style:const TextStyle(fontStyle: FontStyle.italic),
              ),
              ),
            ),
             const DataColumn(label: const Expanded(
              child:const Text(
                'Sifra',
                style:const TextStyle(fontStyle: FontStyle.italic),
              ),
              ),
            ),
             const DataColumn(label: const Expanded(
              child:const Text(
                'Naziv',
                style:const TextStyle(fontStyle: FontStyle.italic),
              ),
              ),
            ),
             const DataColumn(label: const Expanded(
              child:const Text(
                'Cijena',
                style:const TextStyle(fontStyle: FontStyle.italic),
              ),
              ),
            ),
              const DataColumn(label: const Expanded(
              child:const Text(
                'Slika',
                style:const TextStyle(fontStyle: FontStyle.italic),
              ),
              ),
            ), 
      ],rows:const<DataRow>[
        DataRow(
          cells:<DataCell>[
            DataCell(Text('1')),
            DataCell(Text('Rukavice')),
            DataCell(Text('Sifra123')),
            DataCell(Text('Sifra123')),
             DataCell(Text('Sifra123')),
          ],
        ),
        DataRow(
          cells:<DataCell>[
            DataCell(Text('1')),
            DataCell(Text('Rukavice')),
            DataCell(Text('Sifra123')),
            DataCell(Text('Sifra123')),
             DataCell(Text('Sifra123')),
          ],
        ),
      
        
      ]
      
      //rows: result?.result.map((Product e)=>DataRow(onSelectChanged: (selected)=>{
        //if(selected==true){
          //Navigator.of(context).push(
          //MaterialPageRoute(
            //builder: (context)=> ProdutcDetailScreen(product:e,),
         // ),
          //)
       // }
     // },
        //cells: [
        //DataCell(Text(e.proizvodId?.toString()??"")),
        //DataCell(Text(e.sifra.toString()?? "")),
         //DataCell(Text(e.naziv ?? "")),
         //DataCell(Text(formatNumber(e.cijena))),
         //DataCell(e.slika !=""? Container(width: 100,height: 100,child:imageFromBase64String(e.slika!),):Text(""))
      //])).toList()!??[]
      ),
      )
      );
  }
}