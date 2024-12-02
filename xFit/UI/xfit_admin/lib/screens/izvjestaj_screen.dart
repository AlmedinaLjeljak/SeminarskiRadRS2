
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../models/narudzba.dart';
import '../models/product.dart';
import '../providers/narudzba_provider.dart';
import '../providers/product_provders.dart';

class IzvjestajScreen extends StatefulWidget {
  const IzvjestajScreen({Key? key}) : super(key: key);

  @override
  State<IzvjestajScreen> createState() => _IzvjestajScreenState();
}

class _IzvjestajScreenState extends State<IzvjestajScreen> {
  late OrdersProvider _narudzbeProvider;
  late ProductProvider _productProvider;

  List<Narudzba>? _narudzbe;
  List<Product>? _products;

  int? _selectedProduct;
  String _selectedReportType = 'Narudzbe';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _narudzbeProvider = Provider.of<OrdersProvider>(context, listen: false);
    _productProvider = Provider.of<ProductProvider>(context, listen: false);

    _fetchNarudzbe();
  }

  Future<void> _fetchNarudzbe() async {
    try {
      var narudzbeData = await _narudzbeProvider.get();
      setState(() {
        _narudzbe = narudzbeData.result;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchProducts() async {
    try {
      var productsData = await _productProvider.get();
      setState(() {
        _products = productsData.result;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildContent() {
    if (_selectedReportType == 'Narudzbe') {
      return _buildNarudzbeContent();
    } else if (_selectedReportType == 'Proizvodi') {
      return _buildProductContent();
    }
    return Text('Select a report type');
  }

  Widget _buildNarudzbeContent() {
    return ListView.builder(
      itemCount: _narudzbe?.length ?? 0,
      itemBuilder: (context, index) {
        var narudzba = _narudzbe![index];
        return Card(
          elevation: 2,
          child: ListTile(
            title: Text('Narudzba: ${narudzba.brojNarudzbe ?? 'N/A'}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Iznos: ${narudzba.iznos} KM'),
                Text('Status: ${narudzba.status}'),
                Text(
                  'Datum: ${narudzba.datum != null ? DateFormat('yyyy-MM-dd').format(narudzba.datum!) : 'Unknown Date'}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductContent() {
    return ListView.builder(
      itemCount: _products?.length ?? 0,
      itemBuilder: (context, index) {
        var product = _products![index];
        return Card(
          elevation: 2,
          child: ListTile(
            title: Text(product.naziv ?? 'N/A'),
            subtitle: Text('Cijena: ${product.cijena} KM'),
          ),
        );
      },
    );
  }

  pw.Widget _generatePDFContent() {
    if (_selectedReportType == 'Narudzbe' && _narudzbe != null) {
      return pw.Column(
        children: _narudzbe!.map((narudzba) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Broj narudzbe: ${narudzba.brojNarudzbe ?? 'N/A'}'),
              pw.Text('Iznos: ${narudzba.iznos} KM'),
              pw.Text('Status: ${narudzba.status}'),
              pw.Text(
                'Datum: ${narudzba.datum != null ? DateFormat('yyyy-MM-dd').format(narudzba.datum!) : 'Unknown Date'}',
              ),
            ],
          );
        }).toList(),
      );
    } else if (_selectedReportType == 'Proizvodi' && _products != null) {
      return pw.Column(
        children: _products!.map((product) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Naziv proizvoda: ${product.naziv ?? 'N/A'}'),
              pw.Text('Cijena: ${product.cijena} KM'),
            ],
          );
        }).toList(),
      );
    } else {
      return pw.Text('No data available for the selected report type.');
    }
  }

  Future<pw.Document> _generatePDFReport() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('Izvještaj', style: pw.TextStyle(fontSize: 20)),
                pw.SizedBox(height: 20),
                _generatePDFContent(),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  Future<void> _printPDFReport(pw.Document pdf) async {
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izvještaji'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedReportType,
              onChanged: (newValue) {
                setState(() {
                  _selectedReportType = newValue!;
                });
                if (_selectedReportType == 'Narudzbe') {
                  _fetchNarudzbe();
                } else if (_selectedReportType == 'Proizvodi') {
                  _fetchProducts();
                }
              },
              items: <String>['Narudzbe', 'Proizvodi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Odaberi tip izvještaja'),
            ),
            SizedBox(height: 16.0),
            Expanded(child: _buildContent()),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                final pdf = await _generatePDFReport();
                await _printPDFReport(pdf);
              },
              child: Text('Spremi i Štampaj Izvještaj'),
            ),
          ],
        ),
      ),
    );
  }
}
