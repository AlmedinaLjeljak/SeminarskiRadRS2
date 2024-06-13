
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/providers/proizvod_provajder.dart';
import 'package:xfit_admin/screens/product_detail_screen.dart';
import 'package:xfit_admin/utils/util.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

/*class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  SearchResult<Product>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _sifraController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = context.read<ProductProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Product list"),
      child: Container(
        child: Column(children: [
          _buildSearch(),
          _buildDataListView()
        ]),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Naziv ili sifra"),
              controller: _ftsController,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Sifra"),
              controller: _sifraController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              print("Search button pressed");
              print("fts: ${_ftsController.text}, sifra: ${_sifraController.text}");

              try {
                var data = await _productProvider.get(filter: {
                  'fts': _ftsController.text,
                  'sifra': _sifraController.text,
                });

                print("API call successful. Data received: ${data.result}");

                setState(() {
                  result = data;
                });
              } catch (e) {
                print("Error during API call: $e");
              }
            },
            child: Text("Pretraga"),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProdutcDetailScreen(product: null),
                ),
              );
            },
            child: Text("Dodaj"),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(
              label: Expanded(
                child: Text(
                  'ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Sifra',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Naziv',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Cijena',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Slika',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result.map((Product e) {
            return DataRow(
              onSelectChanged: (selected) {
                if (selected == true) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProdutcDetailScreen(product: e),
                    ),
                  );
                }
              },
              cells: [
                DataCell(Text(e.proizvodId?.toString() ?? "")),
                DataCell(Text(e.sifra.toString() ?? "")),
                DataCell(Text(e.naziv ?? "")),
                DataCell(Text(formatNumber(e.cijena))),
                DataCell(e.slika != "" ? Container(width: 100, height: 100, child: imageFromBase64String(e.slika!)) : Text("")),
              ],
            );
          }).toList() ??
              [],
        ),
      ),
    );
  }
}*/

/*
class ProductListScreen extends StatefulWidget{
  const ProductListScreen({Key?key}):super(key:key);

  @override
  State<ProductListScreen> createState()=>_ProductListScreenState();

}

class _ProductListScreenState extends State<ProductListScreen>{
  
  late ProizvodProvajder _productProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _productProvider=context.read<ProizvodProvajder>();
  }
  
  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      title_widget: Text("Product list"),
      child: Container(
        child: Column(children: [
          Text("Test"),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () async{
              print("login proceed");
              //Navigator.of(context).pop();

              var data=await _productProvider.get();
              print("data: $data");
             
            },
           child: Text("Login"))
        ]),
      )

    );
  }
}*/
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProizvodProvajder _productProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      _productProvider = context.read<ProizvodProvajder>();
      print("ProizvodProvajder initialized successfully");
    } catch (e) {
      print("Error initializing ProizvodProvajder: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Product list"),
      child: Container(
        child: Column(
          children: [
            Text("Test"),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () async {
                print("login proceed");
                try {
                  var data = await _productProvider.get();
                  print("data: $data");
                } catch (e) {
                  print("Error during get request: $e");
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
