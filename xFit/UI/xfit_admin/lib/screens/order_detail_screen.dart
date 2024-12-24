


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






/*
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/main.dart';
import 'package:xfit_admin/models/stavkaNarudzbe.dart';
import 'package:xfit_admin/providers/narudzba_provider.dart';
import 'package:xfit_admin/providers/stavka_narudzbe_provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/models/narudzba.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  Narudzba? narudzba;

  OrderDetailScreen({super.key, this.narudzba});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late OrdersProvider _ordersProvider;
  late StavkaNarudzbeProvider stavkaNarudzbeProvider;
  late ProductProvider productProvider;
  List<StavkaNarudzbe> stavkeNarudzbe = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'brojNarudzbe': widget.narudzba?.brojNarudzbe,
      'status': widget.narudzba?.status,
      'datum': widget.narudzba?.datum.toString(),
      'iznos': widget.narudzba?.iznos.toString()
    };
    _ordersProvider = context.read<OrdersProvider>();
    stavkaNarudzbeProvider = StavkaNarudzbeProvider();
    productProvider = ProductProvider();
    _fetchStavkeNarudzbe();

    initForm();
  }

  Future<void> _fetchStavkeNarudzbe() async {
    if (widget.narudzba == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      var narudzbaId = widget.narudzba?.narudzbaId;
      if (narudzbaId != null) {
        var result = await stavkaNarudzbeProvider.getStavkeNarudzbeByNarudzbaId(narudzbaId);
        setState(() {
          stavkeNarudzbe = result;
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle error
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderDetailState = Provider.of<OrderDetailState>(context, listen: false);

    return MasterScreenWidget(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(16),
          child: isLoading ? Container() : SingleChildScrollView(
            child: _buildForm(),
          ) ,
        ),
      ),
      title: "Order ${this.widget.narudzba?.brojNarudzbe}" ?? "Order details",
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        children: [
          FormBuilderTextField(
            decoration: InputDecoration(labelText: "Order number"),
            name: 'brojNarudzbe',
            readOnly: true,
          ),
          SizedBox(height: 10),
          FormBuilderTextField(
            decoration: InputDecoration(labelText: "Status"),
            name: 'status',
            onChanged: (value) {
             final currentValue = _initialValue['status'];
             print(currentValue);
            },
            validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final currentValue = _initialValue['status'];
                  final newValue = value;

                  final allowedTransitions = {
        'Pending': ['Completed', 'Cancelled'],
        'Cancelled': ['Pending'],
      };

      if (currentValue != newValue) {
        if (allowedTransitions.containsKey(currentValue) &&
            allowedTransitions[currentValue] != null &&
            !allowedTransitions[currentValue]!.contains(newValue)) {
          return "Invalid status transition (Allowed transitions: Pending -> Completed/Cancelled; Cancelled -> Pending)";
        }
      }
    }
    return null;
            },
          ),
          SizedBox(height: 10),
          FormBuilderTextField(
            decoration: InputDecoration(labelText: "Total amount"),
            name: 'iznos',
            readOnly: true,
          ),
          SizedBox(height: 10),
          FormBuilderTextField(
            decoration: InputDecoration(labelText: "Order date"),
            name: 'datum',
            readOnly: true,
          ),
          SizedBox(height: 20),

        Text(
          'Order details :',
          style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          ),
)       ,
         
    if (stavkeNarudzbe.isNotEmpty)
    ...stavkeNarudzbe.asMap().entries.map((entry) {
    final index = entry.key;
    final stavka = entry.value;

    return Column(
      children: [
        FormBuilderTextField(
          decoration: InputDecoration(labelText: 'Quantity'),
          name: 'kolicina',
          readOnly: true,
          initialValue: stavka.kolicina.toString(),
        ),
        FutureBuilder<String>(
          future: _getProductName(stavka.proizvodId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FormBuilderTextField(
                decoration: InputDecoration(labelText: 'Product name'),
                name: 'nazivProizvoda_$index',
                readOnly: true,
                initialValue: snapshot.data ?? 'N/A',
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }).toList(),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    print(_formKey.currentState?.value);

                    var request = Map<String, dynamic>.from(_formKey.currentState!.value);

                    try {
                      if (widget.narudzba == null) {
                        await _ordersProvider.insert(request);
                      } 
                      else {
                        var currentStatus = _initialValue['status'];
                        var newStatus = request['status'];

                        if(currentStatus == 'Completed'){
                             showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Error"),
              content: Text("Cannot transition from 'Completed' status."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            ),
          );
                        }else{
                          await _ordersProvider.update(
                          widget.narudzba!.narudzbaId!,
                          request,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Order status successfully updated.'),
                            backgroundColor: Colors.green,
                          ));
                          Navigator.pop(context, 'reload');
                      //}
                      }
                      }
                    } on Exception catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> _getProductName(int? productId) async {
    if (productId == null) {
      return 'N/A';
    }

    try {
      var product = await productProvider.getById(productId);
      return product.naziv ?? 'N/A';
    } catch (e) {
      return 'N/A';
    }
  }
}*/