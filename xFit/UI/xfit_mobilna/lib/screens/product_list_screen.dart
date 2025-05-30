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
  TextEditingController _ftsController = new TextEditingController();
  TextEditingController _sifraController = new TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  List<Product> dataRecomm = [];

  late RecommendResultProvider _recommendResultProvider = RecommendResultProvider();

  String _selectedSortDirection = 'ascending';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
      _favoritesProvider = Provider.of<OmiljeniProizvodProvider>(context, listen: false);
      _korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
      _recommendResultProvider = context.read<RecommendResultProvider>();
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
              Container(
  height: 200,
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: _buildProductCardList(result, false),
    ),
  ),
),

              SizedBox(
                height: 15,
              ),
              Text(
                "Recommended products:",  style: TextStyle(color: Colors.blueGrey,fontSize: 25,fontWeight: FontWeight.w600),),
              SizedBox(height: 15),

              Container(
                height: 200,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 4 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30),
                  scrollDirection: Axis.horizontal,
                  children: _buildProductCardList(resultRecomm, true),
                ),
              )
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


List<Widget> _buildProductCardList(dataX, bool rec) {
    if (rec == true && (result?.result.isEmpty ?? true)) {
  return [Text("No recommended articles")];
}
if (rec == false && (result?.result.isEmpty ?? true)) {
  return [Text("Loading...")];
}

List<Widget> list = (dataX?.result ?? [])
    .map((x) => Container(
              child: Column(
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
                      width: 100,
                      child: x.slika == null || x.slika.isEmpty
                         
                          ? Image.asset("assets/images/no-image.jpg")
                          : imageFromBase64String(x.slika!),
                    ),
                  ),
                  Text(x.naziv ?? ""),
                  Text("${formatNumber(x.cijena)} KM"),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () async {
                          _cartProvider.addToCart(x);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            duration: Duration(milliseconds: 1000),
                            content: Text("Successful added to cart."),
                          ));
                          Product _x = x;
                          int id = _x.proizvodId!;
                          try{
                          var recommendResult = await _recommendResultProvider.get();
                          var filteredRecommendation = recommendResult.result.where((x) => x.proizvodId == id).toList();
                          if (filteredRecommendation.isNotEmpty) {
                            var matchingRecommendation = filteredRecommendation.first;
                           
                            print(recommendResult);

                            int prviProizvodID = matchingRecommendation.prviProizvodId!;
                            int drugiProizvodID = matchingRecommendation.drugiProizvodId!;
                            int treciProizvodID = matchingRecommendation.treciProizvodId!;
                           
                          var prviRecommendedProduct = await _productProvider.getById(prviProizvodID);
                          var drugiRecommendedProduct = await _productProvider.getById(drugiProizvodID);
                          var treciRecommendedProduct = await _productProvider.getById(treciProizvodID);
                           
                            setState(() {
                               resultRecomm = SearchResult<Product>()
                              ..result = [prviRecommendedProduct, drugiRecommendedProduct, treciRecommendedProduct]
                              ..count = 3; 
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("No matching recommendations found"),
                            ));
                          } 
                          }on Exception catch (e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something bad happened."),));
                          }
                          },
                      ),
                      IconButton(
  icon: Icon(Icons.favorite),
  onPressed: () async {
    try {

      final isProductFavorite = await _favoritesProvider.exists(x.proizvodId!);

      if (!isProductFavorite) {

        await _favoritesProvider.sendRabbit({
          "datumDodavanja": DateTime.now().toUtc().toIso8601String(),
          "proizvodId": x.proizvodId,
          "korisnikId": await getKlijentId(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 1000),
            content: Text("Proizvod ${x.naziv} uspješno dodan u omiljene."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Proizvod je već u omiljenim."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Došlo je do greške pri dodavanju u omiljene."),
        ),
      );
    }
  },
),

                    ],
                  ),
                ],
              ),
            ))
        .cast<Widget>()
        .toList();
    return list;
  }

 Future<int> getKlijentId() async {
    final klijenti = await _korisniciProvider.get(filter: {
      'korisnikUlogas': 'klijent',
    });

    final klijent = klijenti.result.firstWhere((korisnik) => korisnik.korisnickoIme == Authorization.username);

    return klijent.korisnikId!;
  }
}
