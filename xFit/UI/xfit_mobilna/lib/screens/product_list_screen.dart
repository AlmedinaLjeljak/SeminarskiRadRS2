import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobilna/models/product.dart';
import 'package:xfit_mobilna/models/search_result.dart';
import 'package:xfit_mobilna/providers/cart_provider.dart';
import 'package:xfit_mobilna/providers/omiljeni_proizvod_provider.dart';
import 'package:xfit_mobilna/providers/korisnik_providder.dart';
import 'package:xfit_mobilna/providers/product_provider.dart';
import 'package:xfit_mobilna/providers/recommendResult_provider.dart';
import 'package:xfit_mobilna/screens/product_detail_screen.dart';
import 'package:xfit_mobilna/utils/util.dart';
import 'package:xfit_mobilna/widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  late CartProvider _cartProvider;
  late OmiljeniProizvodProvider _favoritesProvider;
  late KorisnisiProvider _korisniciProvider;
  SearchResult<Product>? result;
  SearchResult<Product>? resultRecomm;
  bool isLoading = true;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _sifraController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  late RecommendResultProvider _recommendResultProvider;

  String _selectedSortDirection = 'ascending';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _favoritesProvider =
        Provider.of<OmiljeniProizvodProvider>(context, listen: false);
    _korisniciProvider =
        Provider.of<KorisnisiProvider>(context, listen: false);
    _recommendResultProvider = context.read<RecommendResultProvider>();
  }

  Future<void> _fetchProducts() async {
    try {
      _productProvider =
          Provider.of<ProductProvider>(context, listen: false);
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
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: SizedBox(height: 15)),

            
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final x = result!.result[index];
                    return _buildProductCard(x);
                  },
                  childCount: result?.result.length ?? 0,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.65, 
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 25)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Recommended products:",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15)),

            // Preporučeni proizvodi
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final x = resultRecomm!.result[index];
                    return _buildProductCard(x);
                  },
                  childCount: resultRecomm?.result.length ?? 0,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return FormBuilder(
      key: _formKey,
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
        ],
      ),
    );
  }

  Widget _buildProductCard(Product x) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(x),
                  ),
                );
              },
              child: Container(
                height: 100,
                width: double.infinity,
                child: x.slika == null || x.slika!.isEmpty
                    ? Image.asset("assets/images/no-image.jpg",
                        fit: BoxFit.contain)
                    : imageFromBase64String(x.slika!),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Text(
                x.naziv ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4),
            Text("${formatNumber(x.cijena)} KM"),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    final quantity = cartProvider.getQuantity(x);
                    final isInCart = quantity > 0;

                    if (isInCart) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () => cartProvider.decreaseQuantity(x),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.remove, size: 18),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              quantity.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 4),
                            InkWell(
                              onTap: () => cartProvider.addToCart(x),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.add, size: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () => cartProvider.addToCart(x),
                      );
                    }
                  },
                ),
                FutureBuilder<bool>(
                  future: _favoritesProvider.exists(x.proizvodId!),
                  builder: (context, snapshot) {
                    final isFav = snapshot.data ?? false;
                    return IconButton(
                      icon: Icon(Icons.favorite,
                          color: isFav ? Colors.red : Colors.grey),
                      onPressed: () async {
                        if (!isFav) {
                          await _favoritesProvider.sendRabbit({
                            "datumDodavanja":
                                DateTime.now().toUtc().toIso8601String(),
                            "proizvodId": x.proizvodId,
                            "korisnikId": await getKlijentId(),
                          });
                        } else {
                          await _favoritesProvider.removeByProductId(
                              x.proizvodId!, await getKlijentId());
                        }
                        setState(() {});
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<int> getKlijentId() async {
    final klijenti = await _korisniciProvider.get(filter: {
      'korisnikUlogas': 'klijent',
    });

    final klijent = klijenti.result.firstWhere(
        (korisnik) => korisnik.korisnickoIme == Authorization.username);

    return klijent.korisnikId!;
  }
}
