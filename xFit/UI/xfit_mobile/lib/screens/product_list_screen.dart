import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobile/models/product.dart';
import 'package:xfit_mobile/providers/product_provider.dart';
import 'package:xfit_mobile/screens/product_detail_screen.dart';
import 'package:xfit_mobile/widgets/master_screen.dart';



class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _productProvider = context.read<ProductProvider>();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      var searchResult = await _productProvider.get();
      setState(() {
        _products = searchResult.result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Product List", // Set the title for the AppBar
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: product.slika != null
                        ? Image.network(
                            product.slika!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.image),
                          )
                        : Icon(Icons.image),
                    title: Text(product.naziv ?? "Unknown"),
                    subtitle: Text("Cijena: \KM${product.cijena?.toStringAsFixed(2) ?? "0.00"}"),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
