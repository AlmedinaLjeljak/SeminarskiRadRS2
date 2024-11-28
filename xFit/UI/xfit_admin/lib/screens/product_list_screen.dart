import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/screens/product_detail_screen.dart';
import 'package:xfit_admin/utils/util.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget {
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
    _loadData();  
  }

  
  Future<void> _loadData({String fts = '', String sifra = ''}) async {
    try {
      var data = await _productProvider.get(filter: {
        'fts': fts,
        'sifra': sifra,
      });
      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error during API call: $e");
    }
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
              onChanged: (value) {
                _loadData(
                  fts: value, 
                  sifra: _sifraController.text,
                );
              },
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Sifra"),
              controller: _sifraController,
              onChanged: (value) {
                _loadData(
                  fts: _ftsController.text,
                  sifra: value,
                );
              },
            ),
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
}





