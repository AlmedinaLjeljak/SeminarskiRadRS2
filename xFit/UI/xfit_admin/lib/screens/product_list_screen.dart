/*
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/screens/product_detail_screen.dart';
import 'package:xfit_admin/utils/util.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  SearchResult<Product>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _sifraController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = context.read<ProductProvider>();
    _loadData();
  }

  Future<void> _loadData({String fts = '', String sifra = ''}) async {
    try {
      var data = await _productProvider.get(filter: {
        'fts': fts,
        'sifra': sifra,
      });
      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error during API call: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Product list"),
      child: Column(
        children: [
          _buildSearch(),
          _buildDataListView(),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Naziv ili sifra"),
              controller: _ftsController,
              onChanged: (value) {
                _loadData(
                  fts: value,
                  sifra: _sifraController.text,
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Sifra"),
              controller: _sifraController,
              onChanged: (value) {
                _loadData(
                  fts: _ftsController.text,
                  sifra: value,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enables horizontal scrolling
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'ID',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Sifra',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Naziv',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Cijena',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Slika',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      '',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: result?.result.asMap().entries.map((entry) {
                int index = entry.key;
                Product e = entry.value;

                return DataRow(
                  color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return index.isEven
                          ? Colors.white
                          : const Color.fromARGB(255, 209, 233, 235);
                    },
                  ),
                  onSelectChanged: (selected) {
                    if (selected == true) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: e),
                        ),
                      );
                    }
                  },
                  cells: [
                    DataCell(Text(e.proizvodId?.toString() ?? "")),
                    DataCell(Text(e.sifra ?? "")),
                    DataCell(Text(e.naziv ?? "")),
                    DataCell(Text(formatNumber(e.cijena))),
                    DataCell(
                      e.slika != null && e.slika!.isNotEmpty
                          ? Container(
                              width: 100,
                              height: 100,
                              child: imageFromBase64String(e.slika!),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              child: imageFromBase64String(
                                base64Encode(
                                  File('assets/images/no_image.jpg')
                                      .readAsBytesSync(),
                                ),
                              ),
                            ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(e);
                        },
                      ),
                    ),
                  ],
                );
              }).toList() ??
                  [],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(Product e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteProduct(e);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(Product product) async {
    try {
      await _productProvider.delete(product.proizvodId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product deleted successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
      _loadData(); // Reload data after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete product.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
*/


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/screens/product_detail_screen.dart';
import 'package:xfit_admin/utils/util.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  SearchResult<Product>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _sifraController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = context.read<ProductProvider>();
    _loadData();
  }

  Future<void> _loadData({String fts = '', String sifra = ''}) async {
    try {
      var data = await _productProvider.get(filter: {
        'fts': fts,
        'sifra': sifra,
      });
      setState(() {
        result = data;
      });
    } catch (e) {
      print("Error during API call: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Product list"),
      child: Column(
        children: [
          _buildSearch(),
          _buildDataListView(),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Naziv ili sifra"),
              controller: _ftsController,
              onChanged: (value) {
                _loadData(
                  fts: value,
                  sifra: _sifraController.text,
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Sifra"),
              controller: _sifraController,
              onChanged: (value) {
                _loadData(
                  fts: _ftsController.text,
                  sifra: value,
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: null),
                ),
              ).then((_) {
                // Refresh the data list when returning from the detail screen
                _loadData();
              });
            },
            child: const Text("Add Product"),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enables horizontal scrolling
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'ID',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Sifra',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Naziv',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Cijena',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Slika',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      '',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: result?.result.asMap().entries.map((entry) {
                int index = entry.key;
                Product e = entry.value;

                return DataRow(
                  color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return index.isEven
                          ? Colors.white
                          : const Color.fromARGB(255, 209, 233, 235);
                    },
                  ),
                  onSelectChanged: (selected) {
                    if (selected == true) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: e),
                        ),
                      );
                    }
                  },
                  cells: [
                    DataCell(Text(e.proizvodId?.toString() ?? "")),
                    DataCell(Text(e.sifra ?? "")),
                    DataCell(Text(e.naziv ?? "")),
                    DataCell(Text(formatNumber(e.cijena))),
                    DataCell(
                      e.slika != null && e.slika!.isNotEmpty
                          ? Container(
                              width: 100,
                              height: 100,
                              child: imageFromBase64String(e.slika!),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              child: imageFromBase64String(
                                base64Encode(
                                  File('assets/images/no_image.jpg')
                                      .readAsBytesSync(),
                                ),
                              ),
                            ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(e);
                        },
                      ),
                    ),
                  ],
                );
              }).toList() ??
                  [],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(Product e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteProduct(e);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(Product product) async {
    try {
      await _productProvider.delete(product.proizvodId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product deleted successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
      _loadData(); // Reload data after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete product.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
