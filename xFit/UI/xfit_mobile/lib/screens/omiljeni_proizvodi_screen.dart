import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobile/models/omiljeni_proizvod.dart';
import 'package:xfit_mobile/providers/omiljeni_proizvod_provider.dart';
import 'package:xfit_mobile/utils/util.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../widgets/master_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late OmiljeniProizvodProvider _favoritesProvider;
  late ProductProvider _productProvider;
  List<OmiljeniProizvod> favoriteProducts = [];

  @override
  void initState() {
    super.initState();
    _favoritesProvider = Provider.of<OmiljeniProizvodProvider>(context, listen: false);
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    try {
      var data = await _favoritesProvider.get();
      setState(() {
        favoriteProducts = data.result;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Favorites"),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Image')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Actions')), // Change column label for clarity
          ],
          rows: favoriteProducts.isNotEmpty
              ? favoriteProducts.map((favorite) => DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: 100,
                        height: 100,
                        child: FutureBuilder<Product?>(
                          future: _productProvider.getById(favorite.proizvodId!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error');
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return Text('Product not found');
                            } else {
                              final product = snapshot.data!;
                              return imageFromBase64String(product.slika!);
                            }
                          },
                        ),
                      ),
                    ),
                    DataCell(Text(favorite.datumDodavanja.toString())),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteFavorite(favorite.omiljeniProizvodId),
                        color: Colors.red,
                        tooltip: 'Delete from favorites',
                      ),
                    ),
                  ],
                )).toList() // Convert Iterable to List
              : [DataRow(cells: [DataCell(Text('No favorites available'))])],
        ),
      ),
    );
  }

  _deleteFavorite(int? omiljeniProizvodId) async {
    try {
      await _favoritesProvider.delete(omiljeniProizvodId);
      _fetchFavorites();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product successfully removed from favorites.")),
      );
    } catch (e) {
      print(e);
    }
  }
}
