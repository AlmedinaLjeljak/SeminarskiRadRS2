import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/main.dart';
import 'package:xfit_admin/models/narudzba.dart';
import 'package:xfit_admin/models/stavkaNarudzbe.dart';
import 'package:xfit_admin/providers/narudzba_provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:intl/intl.dart';
import 'package:xfit_admin/providers/stavka_narudzbe_provider.dart';
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
      'datum': widget.narudzba?.datum != null
    ? DateFormat('yyyy-MM-dd').format(widget.narudzba!.datum!)
    : '',
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240), 
        title: Text('Order ${this.widget.narudzba?.brojNarudzbe}' ?? "Order details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(16),
          child: isLoading
              ? Container()
              : SingleChildScrollView(
                  child: _buildForm(),
                ),
        ),
      ),
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
            'Order details:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
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
                      } else {
                        var currentStatus = _initialValue['status'];
                        var newStatus = request['status'];

                        if (currentStatus == 'Completed') {
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
                        } else {
                          await _ordersProvider.update(
                            widget.narudzba!.narudzbaId!,
                            request,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Order status successfully updated.'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context, 'reload');
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
}
