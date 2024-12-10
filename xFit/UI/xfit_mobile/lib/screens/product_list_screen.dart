import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobile/models/product.dart';
import 'package:xfit_mobile/models/search_result.dart';
import 'package:xfit_mobile/providers/cart_provider.dart';
import 'package:xfit_mobile/providers/omiljeni_proizvod_provider.dart';
import 'package:xfit_mobile/providers/korisnik_providder.dart';
import 'package:xfit_mobile/providers/product_provider.dart';
import 'package:xfit_mobile/screens/product_detail_screen.dart';
import 'package:xfit_mobile/utils/util.dart';
import 'package:xfit_mobile/widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  late CartProvider _cartProvider;
  late KorisnisiProvider _korisniciProvider;
  SearchResult<Product>? result;
  bool isLoading = true;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _sifraController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  String _selectedSortDirection = 'ascending';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
  }

  Future<void> _fetchProducts() async {
    try {
      _productProvider = Provider.of<ProductProvider>(context, listen: false);
      _cartProvider = Provider.of<CartProvider>(context, listen: false);
      var data = await _productProvider.get(filter: {
        'fts': _ftsController.text,
        'sifra': _sifraController.text,
      });

      setState(() {
        result = data;
        if (_selectedSortDirection == 'ascending') {
          result?.result.sort((a, b) => a.cijena!.compareTo(b.cijena!));
        } else {
          result?.result.sort((a, b) => b.cijena!.compareTo(a.cijena!));
        }
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Products"),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearch(),
              // GridView for displaying products in two columns
              Container(
                padding: EdgeInsets.all(8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75, // Adjust the ratio for item size
                  ),
                  itemCount: result?.result.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = result!.result[index];
                    return _buildProductCard(product);
                  },
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: "Product name"),
                controller: _ftsController,
                onChanged: (_) => _fetchProducts(),
              ),
            ),
            SizedBox(width: 8),
            DropdownButton<String>(
              value: _selectedSortDirection,
              onChanged: (newValue) {
                setState(() {
                  _selectedSortDirection = newValue!;
                  _fetchProducts();
                });
              },
              items: <String>['ascending', 'descending']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product),
                ),
              );
            },
            child: Container(
              height: 100,
              width: double.infinity,
              child: product.slika == null || (product.slika?.isEmpty?? true)
                  ? Image.asset("assets/images/logo.png")
                  : imageFromBase64String(product.slika!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.naziv ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("${formatNumber(product.cijena)} KM"),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () async {
                  _cartProvider.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.green,
                    duration: Duration(milliseconds: 1000),
                    content: Text("Successfully added to cart."),
                  ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
