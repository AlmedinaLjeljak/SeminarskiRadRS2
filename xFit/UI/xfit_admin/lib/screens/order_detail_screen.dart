
/*
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
}*/





/*
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/stavkaNarudzbe.dart';
import 'package:xfit_admin/providers/narudzba_provider.dart';
import 'package:xfit_admin/providers/stavka_narudzbe_provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/models/narudzba.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  final Narudzba? narudzba;

  OrderDetailScreen({Key? key, this.narudzba}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late StavkaNarudzbeProvider _stavkaNarudzbeProvider;
  late ProductProvider _productProvider;
  List<StavkaNarudzbe> _stavkeNarudzbe = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _stavkaNarudzbeProvider = StavkaNarudzbeProvider();
    _productProvider = ProductProvider();
    _fetchStavkeNarudzbe();
    _initializeForm();
  }

  Future<void> _fetchStavkeNarudzbe() async {
    if (widget.narudzba == null || widget.narudzba!.narudzbaId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      print('Fetching stavke for narudzbaId: ${widget.narudzba!.narudzbaId}');
      var result = await _stavkaNarudzbeProvider.getStavkeNarudzbeByNarudzbaId(
        widget.narudzba!.narudzbaId!,
      );
      setState(() {
        _stavkeNarudzbe = result.where((s) => s.narudzbaId == widget.narudzba!.narudzbaId).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching stavke: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _initializeForm() {
    _initialValue = {
      'brojNarudzbe': widget.narudzba?.brojNarudzbe,
      'status': widget.narudzba?.status,
      'datum': widget.narudzba?.datum.toString(),
      'iznos': widget.narudzba?.iznos.toString(),
    };
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteStavka(int? stavkaId) async {
    try {
      // Pozivanje delete metode iz base providera
      await _stavkaNarudzbeProvider.delete(stavkaId);
      setState(() {
        _stavkeNarudzbe.removeWhere((stavka) => stavka.stavkaNarudzbeId == stavkaId);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item deleted')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete item')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Order ${widget.narudzba?.brojNarudzbe ?? "Details"}",
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormBuilder(
                  key: _formKey,
                  initialValue: _initialValue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderTextField(
                        name: 'brojNarudzbe',
                        readOnly: true,
                        decoration: InputDecoration(labelText: "Order Number"),
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'status',
                        decoration: InputDecoration(labelText: "Status"),
                      ),
                      SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'iznos',
                        readOnly: true,
                        decoration: InputDecoration(labelText: "Total Amount"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Order Details:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ..._stavkeNarudzbe.map((stavka) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: FutureBuilder<String>(
                              future: _getProductName(stavka.proizvodId),
                              builder: (context, snapshot) {
                                return ListTile(
                                  title: Text(snapshot.data ?? "Product Name"),
                                  subtitle: Text("Quantity: ${stavka.kolicina}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _deleteStavka(stavka.stavkaNarudzbeId),
                                  ),
                                );
                              },
                            ),
                          )),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, 'reload');
                        },
                        child: Text("Back"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<String> _getProductName(int? productId) async {
    if (productId == null) return 'Unknown';
    try {
      var product = await _productProvider.getById(productId);
      return product.naziv ?? 'Unknown';
    } catch (e) {
      return 'Error loading product';
    }
  }
}*/









import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/models/stavkaNarudzbe.dart';
import 'package:xfit_admin/providers/narudzba_provider.dart';
import 'package:xfit_admin/providers/stavka_narudzbe_provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/models/narudzba.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  final Narudzba? narudzba;

  OrderDetailScreen({Key? key, this.narudzba}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  Map<String, dynamic> _initialValue = {};
  late StavkaNarudzbeProvider _stavkaNarudzbeProvider;
  late ProductProvider _productProvider;
  List<StavkaNarudzbe> _stavkeNarudzbe = [];
  bool isLoading = true;
  int? _selectedProductId;

  @override
  void initState() {
    super.initState();
    _stavkaNarudzbeProvider = StavkaNarudzbeProvider();
    _productProvider = ProductProvider();
    _fetchStavkeNarudzbe();
    _initializeForm();
  }

  Future<void> _fetchStavkeNarudzbe() async {
    print('Fetching stavke for narudzbaId: ${widget.narudzba?.narudzbaId}');
    if (widget.narudzba == null || widget.narudzba!.narudzbaId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      print('Sending request to fetch stavke');
      var result = await _stavkaNarudzbeProvider.getStavkeNarudzbeByNarudzbaId(
        widget.narudzba!.narudzbaId!,
      );
      setState(() {
        _stavkeNarudzbe = result.where((s) => s.narudzbaId == widget.narudzba!.narudzbaId).toList();
        isLoading = false;
      });
      print('Fetched stavke: $_stavkeNarudzbe');
    } catch (e) {
      print('Error fetching stavke: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _initializeForm() {
    print('Initializing form with data: ${widget.narudzba}');
    _initialValue = {
      'brojNarudzbe': widget.narudzba?.brojNarudzbe,
      'status': widget.narudzba?.status,
      'datum': widget.narudzba?.datum.toString(),
      'iznos': widget.narudzba?.iznos.toString(),
    };
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteStavka(int? stavkaId) async {
    print('Deleting stavka with id: $stavkaId');
    try {
      await _stavkaNarudzbeProvider.delete(stavkaId);
      setState(() {
        _stavkeNarudzbe.removeWhere((stavka) => stavka.stavkaNarudzbeId == stavkaId);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item deleted')));
    } catch (e) {
      print('Error deleting stavka: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete item')));
    }
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<SearchResult<Product>>(
                future: _productProvider.get(), // Fetch all products
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error loading products');
                  } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
                    return Text('No products available');
                  } else {
                    var products = snapshot.data!.result;
                    return DropdownButtonFormField<int>(
                      value: _selectedProductId,
                      decoration: InputDecoration(labelText: "Select Product"),
                      onChanged: (value) {
                        setState(() {
                          _selectedProductId = value;
                          print('Selected product ID: $value'); // Added print
                        });
                      },
                      items: products.map((product) {
                        return DropdownMenuItem<int>(
                          value: product.proizvodId,
                          child: Text(product.naziv ?? "Unknown Product"),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a product';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  var kolicina = _quantityController.text;
                  var proizvodId = _selectedProductId;
                  print('Adding item with Product ID: $proizvodId and Quantity: $kolicina');
                  await _addItem(proizvodId, int.tryParse(kolicina) ?? 0);
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

 Future<void> _addItem(int? proizvodId, int kolicina) async {
  if (widget.narudzba == null || proizvodId == null) return;

  try {
    var newItem = StavkaNarudzbe(
      null, // stavkaNarudzbeId will be generated
      kolicina,
      widget.narudzba?.narudzbaId,
      proizvodId,
    );
    print('Sending request to add item with Product ID: $proizvodId and Quantity: $kolicina');
    print('Request Payload: $newItem'); // Print the request data
    await _stavkaNarudzbeProvider.insert(newItem);
    _fetchStavkeNarudzbe(); // Refresh the list
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added')));
  } catch (e) {
    print('Error adding item: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add item')));
  }
}


  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Order ${widget.narudzba?.brojNarudzbe ?? "Details"}",
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: _initialValue['brojNarudzbe'],
                        readOnly: true,
                        decoration: InputDecoration(labelText: "Order Number"),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: _initialValue['status'],
                        decoration: InputDecoration(labelText: "Status"),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: _initialValue['iznos'],
                        readOnly: true,
                        decoration: InputDecoration(labelText: "Total Amount"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Order Details:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ..._stavkeNarudzbe.map((stavka) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: FutureBuilder<String>(
                              future: _getProductName(stavka.proizvodId),
                              builder: (context, snapshot) {
                                return ListTile(
                                  title: Text(snapshot.data ?? "Product Name"),
                                  subtitle: Text("Quantity: ${stavka.kolicina}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _deleteStavka(stavka.stavkaNarudzbeId),
                                  ),
                                );
                              },
                            ),
                          )),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _showAddItemDialog,
                        child: Text("Add Item"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, 'reload');
                        },
                        child: Text("Back"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<String> _getProductName(int? productId) async {
    if (productId == null) return 'Unknown';
    try {
      var product = await _productProvider.getById(productId);
      return product.naziv ?? 'Unknown';
    } catch (e) {
      print('Error loading product name: $e');
      return 'Error loading product';
    }
  }
}
