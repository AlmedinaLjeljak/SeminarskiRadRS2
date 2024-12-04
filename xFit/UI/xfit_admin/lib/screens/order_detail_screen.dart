/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xfit_admin/models/stavkaNarudzbe.dart';
import 'package:xfit_admin/providers/stavka_narudzbe_provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/models/narudzba.dart';

class OrderDetailScreen extends StatefulWidget {
  final Narudzba narudzba;

  OrderDetailScreen({Key? key, required this.narudzba}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isLoading = true;
  List<StavkaNarudzbe> stavkeNarudzbe = [];
  final StavkaNarudzbeProvider _stavkaNarudzbeProvider = StavkaNarudzbeProvider();
  final ProductProvider _productProvider = ProductProvider();

  @override
  void initState() {
    super.initState();
    _fetchStavkeNarudzbe();
  }

  Future<void> _fetchStavkeNarudzbe() async {
    try {
      var result = await _stavkaNarudzbeProvider.getStavkeNarudzbeByNarudzbaId(widget.narudzba.narudzbaId!);
      setState(() {
        stavkeNarudzbe = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching stavke: $e");
    }
  }

  Future<void> _updateStavka(StavkaNarudzbe stavka) async {
    try {
      var updatedStavka = StavkaNarudzbe(stavka.stavkaNarudzbeId, stavka.kolicina, stavka.proizvodId, stavka.narudzbaId);
      var updatedItem = await _stavkaNarudzbeProvider.update(stavka.stavkaNarudzbeId!, updatedStavka);

      setState(() {
        int index = stavkeNarudzbe.indexWhere((element) => element.stavkaNarudzbeId == updatedItem.stavkaNarudzbeId);
        if (index != -1) {
          stavkeNarudzbe[index] = updatedItem;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Stavka uspešno ažurirana!')));
    } catch (e) {
      print("Error updating stavka: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Greška prilikom ažuriranja stavke.')));
    }
  }

  Future<void> _deleteStavka(int stavkaId) async {
    try {
      await _stavkaNarudzbeProvider.delete(stavkaId);

      setState(() {
        stavkeNarudzbe.removeWhere((element) => element.stavkaNarudzbeId == stavkaId);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Stavka uspešno obrisana!')));
    } catch (e) {
      print("Error deleting stavka: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Greška prilikom brisanja stavke.')));
    }
  }

  // Funkcija za dodavanje nove stavke u narudžbu
  Future<void> _addStavka() async {
    final TextEditingController kolicinaController = TextEditingController();
    int? proizvodId;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dodaj novu stavku'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: kolicinaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Unesite količinu'),
              ),
              DropdownButton<int>(
                hint: Text('Izaberite proizvod'),
                value: proizvodId,
                onChanged: (int? newValue) {
                  setState(() {
                    proizvodId = newValue;
                  });
                },
                items: // Dodajte vašu listu proizvoda ovde
                    [
                  DropdownMenuItem(value: 1, child: Text('Proizvod 1')),
                  DropdownMenuItem(value: 2, child: Text('Proizvod 2')),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (kolicinaController.text.isNotEmpty && proizvodId != null) {
                  int kolicina = int.parse(kolicinaController.text);
                  StavkaNarudzbe novaStavka = StavkaNarudzbe(
                    null, // StavkaNarudzbeId može biti null jer server će je generisati
                    kolicina,
                    proizvodId,
                    widget.narudzba.narudzbaId,
                  );

                  _stavkaNarudzbeProvider.insert(novaStavka).then((newStavka) {
                    setState(() {
                      stavkeNarudzbe.add(newStavka); // Ažurirajte listu sa novom stavkom
                    });

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Stavka uspešno dodata!')));
                    Navigator.of(context).pop();
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Greška pri dodavanju stavke.')));
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Molimo vas popunite sva polja.')));
                }
              },
              child: Text('Dodaj'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Otkaži'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details ${widget.narudzba.brojNarudzbe ?? ''}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Number: ${widget.narudzba.brojNarudzbe}'),
                  Text('Status: ${widget.narudzba.status ?? 'Unknown'}'),
                  Text('Total Amount: ${(widget.narudzba.iznos ?? 0).toStringAsFixed(2)} KM'),
                  Text('Order Date: ${widget.narudzba.datum != null ? DateFormat('yyyy-MM-dd').format(widget.narudzba.datum!) : 'Unknown Date'}'),
                  SizedBox(height: 20),
                  Text('Order Items:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: stavkeNarudzbe.length,
                      itemBuilder: (context, index) {
                        var stavka = stavkeNarudzbe[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text('Item ${index + 1}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Quantity: ${stavka.kolicina}'),
                                FutureBuilder<String>(
                                  future: _getProductName(stavka.proizvodId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return Text('Product: ${snapshot.data ?? 'N/A'}');
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _showUpdateDialog(stavka);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteStavka(stavka.stavkaNarudzbeId!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20), // Razmak pre dugmeta
                  ElevatedButton(
                    onPressed: _addStavka, // Pozivanje funkcije za dodavanje nove stavke
                    child: Text('Dodaj novu stavku'),
                  ),
                ],
              ),
      ),
    );
  }

  Future<String> _getProductName(int? proizvodId) async {
    if (proizvodId == null) return 'N/A';
    try {
      var product = await _productProvider.getById(proizvodId);
      return product.naziv ?? 'N/A';
    } catch (e) {
      return 'N/A';
    }
  }

  void _showUpdateDialog(StavkaNarudzbe stavka) {
    final TextEditingController kolicinaController = TextEditingController(text: stavka.kolicina?.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Quantity for Item ${stavka.stavkaNarudzbeId}'),
          content: TextField(
            controller: kolicinaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter New Quantity'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                int newKolicina = int.tryParse(kolicinaController.text) ?? stavka.kolicina!;
                stavka.kolicina = newKolicina;
                _updateStavka(stavka);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xfit_admin/models/stavkaNarudzbe.dart';
import 'package:xfit_admin/providers/stavka_narudzbe_provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/models/narudzba.dart';

class OrderDetailScreen extends StatefulWidget {
  final Narudzba narudzba;

  OrderDetailScreen({Key? key, required this.narudzba}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isLoading = true;
  List<StavkaNarudzbe> stavkeNarudzbe = [];
  final StavkaNarudzbeProvider _stavkaNarudzbeProvider = StavkaNarudzbeProvider();
  final ProductProvider _productProvider = ProductProvider();

  @override
  void initState() {
    super.initState();
    _fetchStavkeNarudzbe();
  }

  Future<void> _fetchStavkeNarudzbe() async {
    try {
      var result = await _stavkaNarudzbeProvider.getStavkeNarudzbeByNarudzbaId(widget.narudzba.narudzbaId!);
      setState(() {
        stavkeNarudzbe = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching stavke: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240), 
        title: Text(
          'Order Details ${widget.narudzba.brojNarudzbe ?? ''}',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Number: ${widget.narudzba.brojNarudzbe}'),
                  Text('Status: ${widget.narudzba.status ?? 'Unknown'}'),
                  Text('Total Amount: ${(widget.narudzba.iznos ?? 0).toStringAsFixed(2)} KM'),
                  Text('Order Date: ${widget.narudzba.datum != null ? DateFormat('yyyy-MM-dd').format(widget.narudzba.datum!) : 'Unknown Date'}'),
                  SizedBox(height: 20),
                  Text('Order Items:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: stavkeNarudzbe.length,
                      itemBuilder: (context, index) {
                        var stavka = stavkeNarudzbe[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text('Item ${index + 1}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Quantity: ${stavka.kolicina}'),
                                FutureBuilder<String>(
                                  future: _getProductName(stavka.proizvodId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return Text('Product: ${snapshot.data ?? 'N/A'}');
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _showUpdateDialog(stavka);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteStavka(stavka.stavkaNarudzbeId!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: Icon(Icons.add),
        tooltip: 'Add new item',
      ),
    );
  }

  Future<String> _getProductName(int? proizvodId) async {
    if (proizvodId == null) return 'N/A';
    try {
      var product = await _productProvider.getById(proizvodId);
      return product.naziv ?? 'N/A';
    } catch (e) {
      return 'N/A';
    }
  }

  void _showUpdateDialog(StavkaNarudzbe stavka) {
    final TextEditingController kolicinaController = TextEditingController(text: stavka.kolicina?.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Item Quantity'),
          content: TextField(
            controller: kolicinaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Quantity'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateStavka(stavka, int.tryParse(kolicinaController.text) ?? stavka.kolicina!);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog() async {
    final TextEditingController kolicinaController = TextEditingController();
    List<Map<String, dynamic>> products = await _fetchProducts();
    Map<String, dynamic>? selectedProduct;

    if (products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No products available')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<Map<String, dynamic>>(
                decoration: InputDecoration(labelText: 'Select Product'),
                value: selectedProduct,
                items: products.map<DropdownMenuItem<Map<String, dynamic>>>((product) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: product,
                    child: Text(product['naziv']),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedProduct = value;
                },
              ),
              TextField(
                controller: kolicinaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedProduct != null && kolicinaController.text.isNotEmpty) {
                  _addNewStavka(
                    selectedProduct!['id'],
                    int.tryParse(kolicinaController.text),
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item successfully added!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid input')),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchProducts() async {
    try {
      var result = await _productProvider.get();
      return result.result.map((product) {
        return {
          'id': product.proizvodId,
          'naziv': product.naziv,
        };
      }).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  void _addNewStavka(int? proizvodId, int? kolicina) {
    if (proizvodId == null || kolicina == null || kolicina <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid input for new item')),
      );
      return;
    }

    setState(() {
      stavkeNarudzbe.add(
        StavkaNarudzbe(null, kolicina, proizvodId, widget.narudzba.narudzbaId),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item successfully added to the cart!')),
    );
  }

  void _updateStavka(StavkaNarudzbe stavka, int newQuantity) {
    setState(() {
      stavka.kolicina = newQuantity;
    });
  }

  void _deleteStavka(int stavkaId) {
    setState(() {
      stavkeNarudzbe.removeWhere((s) => s.stavkaNarudzbeId == stavkaId);
    });
  }
}
