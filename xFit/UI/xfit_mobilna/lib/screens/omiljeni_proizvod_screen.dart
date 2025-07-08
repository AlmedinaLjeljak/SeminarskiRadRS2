import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobilna/models/omiljeni_proizvod.dart';
import 'package:xfit_mobilna/providers/korisnik_providder.dart';
import 'package:xfit_mobilna/providers/omiljeni_proizvod_provider.dart';
import 'package:xfit_mobilna/utils/util.dart';

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
  late KorisnisiProvider _korisniciProvider;
  late ProductProvider _productProvider;
  List<OmiljeniProizvod> favoriteProducts = [];

  @override
  void initState() {
    super.initState();
    _favoritesProvider = Provider.of<OmiljeniProizvodProvider>(context, listen: false);
    _korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
    _productProvider = Provider.of<ProductProvider>(context, listen: false);

    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    try {
      final patientId = await getPatientId();
      var data = await _favoritesProvider.get(filter: {
        'korisnikId': patientId.toString(),
      });
      setState(() {
        favoriteProducts = data.result;
      });
    } catch (e) {
      print("Greška prilikom dohvata omiljenih proizvoda: $e");
    }
  }

  Future<int> getPatientId() async {
    final pacijenti = await _korisniciProvider.get(filter: {
      'korisnikUlogas': 'klijent',
    });

    final pacijent = pacijenti.result.firstWhere(
      (korisnik) => korisnik.korisnickoIme == Authorization.username,
    );

    return pacijent.korisnikId!;
  }

  Future<Product?> _getProduct(int proizvodId) async {
    return await _productProvider.getById(proizvodId);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Favorites"),
      child: SingleChildScrollView(
        child: Column(
          children: favoriteProducts.map((favorite) {
            return FutureBuilder<Product?>(
              future: _getProduct(favorite.proizvodId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                  return const Text('Error loading product');
                } else {
                  final product = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                base64Decode(product.slika!),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                product.naziv ?? 'No name',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              tooltip: "Remove from favorites",
                              onPressed: () => _deleteFavorite(favorite.omiljeniProizvodId),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _deleteFavorite(int? omiljeniProizvodId) async {
    try {
      await _favoritesProvider.delete(omiljeniProizvodId);
      await _fetchFavorites();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product successfully removed from favorites."),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("Greška prilikom brisanja: $e");
    }
  }
}
