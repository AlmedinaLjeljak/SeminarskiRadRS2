

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/clanska_karta.dart';
import 'package:xfit_admin/models/korisnik.dart';
import 'package:xfit_admin/models/narudzba.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/models/stavkaNarudzbe.dart';
import 'package:xfit_admin/providers/clanska_karta_provider.dart';
import 'package:xfit_admin/providers/korisnici_provider.dart';
import 'package:xfit_admin/providers/narudzba_provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/providers/stavka_narudzbe_provider.dart';

class IzvjestajScreen extends StatefulWidget {
  const IzvjestajScreen({Key? key}) : super(key: key);

  @override
  State<IzvjestajScreen> createState() => _IzvjestajScreenState();
}

class _IzvjestajScreenState extends State<IzvjestajScreen> {
  late KorisnisiProvider _korisniciProvider;
  late OrdersProvider _narudzbeProvider;
  late ClanskaKartaProvider _clanskaKartaProvider;
  late StavkaNarudzbeProvider stavkaNarudzbeProvider;
  late ProductProvider productProvider;



  SearchResult<Korisnik>? result;
  List<Narudzba>? _narudzbe;
  List<ClanskaKarta>? _clanskaKarta;
  List<StavkaNarudzbe> stavkeNarudzbe = [];

  int? _selectedKlijent;
  String _selectedReportType = 'Narudzbe';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
    _narudzbeProvider = Provider.of<OrdersProvider>(context, listen: false);
    _clanskaKartaProvider = Provider.of<ClanskaKartaProvider>(context, listen: false);
    stavkaNarudzbeProvider = StavkaNarudzbeProvider();
    productProvider = ProductProvider();


    _fetchKlijenti();
  }

  Future<void> _fetchKlijenti() async {
    try {
      var data = await _korisniciProvider.get(filter: {
        'korisnikUlogaId': 'klijent',
      });

      setState(() {
        result = data;
        if (result?.result.isNotEmpty == true) {
          _selectedKlijent = result!.result[0].korisnikId;
          if (_selectedReportType == 'Narudzbe') {
            _fetchNarudzbeForKlijent(_selectedKlijent!);
          } else if (_selectedReportType == 'Clanska karta') {
            _fetchClanskaKartaForKlijent(_selectedKlijent!);
          }
        } else {
          _selectedKlijent = null;
        }
      });
    } catch (e) {
      print(e);
    }
  }

Future<void> _fetchDataForSelectedType(int klijentId) async {
  if (_selectedReportType == 'Narudzbe') {
    await _fetchNarudzbeForKlijent(klijentId);
  } else if (_selectedReportType == 'Clanska karta') {
    await _fetchClanskaKartaForKlijent(klijentId);
  }
}


  Future<void> _fetchNarudzbeForKlijent(int klijentId) async {
    try {
      var narudzbeData = await _narudzbeProvider.get(filter: {
        'korisnikId': klijentId,
      });
      setState(() {
        _narudzbe = narudzbeData.result;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchClanskaKartaForKlijent(int klijentId) async {
    try {
      var clanskaKartaData = await _clanskaKartaProvider.get(filter: {
        'korisnikId': klijentId,
      });
      setState(() {
        _clanskaKarta = clanskaKartaData.result;
      });
    } catch (e) {
      print(e);
    }
  }


Widget _buildContent() {
  if (_selectedKlijent == null) {
    return Text('Please select a client');
  }

  if (_selectedReportType == 'Clanska karta') {
    if (_clanskaKarta == null) {
      return FutureBuilder<void>(
        future: _fetchClanskaKartaForKlijent(_selectedKlijent!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error loading data');
          } else {
            return _buildClanskaKartaContent();
          }
        },
      );
    } else {
      return _buildClanskaKartaContent();
    }
  } else if (_selectedReportType == 'Narudzbe') {
    if (_narudzbe == null) {
      return FutureBuilder<void>(
        future: _fetchNarudzbeForKlijent(_selectedKlijent!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error loading data');
          } else {
            return _buildNarudzbeContent();
          }
        },
      );
    } else {
      return _buildNarudzbeContent();
    }
  }
  return Text('Select a report type');
}


  Widget _buildNarudzbeContent() {
    return Container(
    height: 300, 
    child: ListView.builder(
      itemCount: _narudzbe!.length,
      itemBuilder: (context, index) {
        var narudzba = _narudzbe![index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(narudzba.brojNarudzbe ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${narudzba.iznos.toString()} KM"),
                    SizedBox(height: 8),
                    Text(
                      'Created on: ${narudzba.datum != null ? DateFormat('yyyy-MM-dd').format(narudzba.datum!) : 'Unknown Date'}',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
               ElevatedButton(
  onPressed: () async {
    await _fetchStavkeNarudzbe(narudzba);
    
    showDialog(context: context, builder: (BuildContext context) {
      print(stavkeNarudzbe);
      return AlertDialog(
        title: Text("Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (stavkeNarudzbe != null) 
              for (var stavka in stavkeNarudzbe!) 
                Column(
                  children: [
                    Text("Quantity: ${stavka.kolicina.toString()}"),
                    FutureBuilder<String>(
                      future: getProductName(stavka.proizvodId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text("Product Name: ${snapshot.data ?? 'N/A'}");
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    Divider(), 
                  ],
                ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      );
    });
  },
  child: Text("Details"),
),


                   ],
                ),
              ),
            ),
          ),
        );
      },
    ),
    );
  }

  Future<String> getProductName(int? proizvodId) async{
     if (proizvodId == null) {
      return 'N/A';
    }

    try {
      var product = await productProvider.getById(proizvodId);
      return product.naziv ?? 'N/A';
    } catch (e) {
      return 'N/A';
    }
  }

_fetchStavkeNarudzbe(Narudzba narudzba) async {
  if (narudzba == null) {
    setState(() {
      isLoading = false;
    });
    return;
  }
  try {
    var narudzbaId = narudzba.narudzbaId;
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
      stavkeNarudzbe = []; 
    });
  }
}



  Widget _buildClanskaKartaContent() {
    return Column(
      children: _clanskaKarta!.map((clanskaKarta) {
        return Text(clanskaKarta.sadrzaj.toString());
      }).toList(),
    );
  }

  pw.Widget _generatePDFContent() {
  if (_selectedReportType == 'Narudzbe' && _narudzbe != null) {
    return pw.Column(
      children: _narudzbe!.map((narudzba) {
        return pw.Container(
          padding: pw.EdgeInsets.symmetric(vertical: 8.0),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Broj narudzbe: ${narudzba.brojNarudzbe ?? ''}'),
              pw.Text('Iznos: ${narudzba.iznos} KM'),
              pw.Text('Status: ${narudzba.status}'),
              pw.Text(
                'Datum: ${narudzba.datum != null ? DateFormat('yyyy-MM-dd').format(narudzba.datum!) : 'Unknown Date'}',
              ),
            ],
          ),
        );
      }).toList(),
    );
  } else if (_selectedReportType == 'Clanska karta' && _clanskaKarta != null) {
    return pw.Column(
      children: _clanskaKarta!.map((clanskaKarta) {
        return pw.Text(clanskaKarta.sadrzaj.toString());
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
          child: pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 2),
            ),
            padding: pw.EdgeInsets.all(20),
            child: pw.Column(
              children: [
                pw.Text('PDF Report Content', style: pw.TextStyle(fontSize: 20)),
                pw.SizedBox(height: 20),
                _generatePDFContent(), 
              ],
            ),
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
      backgroundColor: const Color.fromARGB(255, 186, 231, 240),
      title: Text('Reports'),
    ),
    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),

            // Dropdown za klijenta
            DropdownButton<int>(
              value: _selectedKlijent,
              onChanged: (newValue) {
                setState(() {
                  _selectedKlijent = newValue!;
                });
                _fetchDataForSelectedType(_selectedKlijent!); // <-- DODANO
              },
              items: result?.result.map<DropdownMenuItem<int>>((Korisnik korisnik) {
                return DropdownMenuItem<int>(
                  value: korisnik.korisnikId,
                  child: Text(korisnik.ime!),
                );
              }).toList() ?? [],
              hint: Text('Odaberi klijenta'),
            ),

            SizedBox(height: 16.0),

            // Dropdown za tip izvještaja
            DropdownButton<String>(
              value: _selectedReportType,
              onChanged: (newValue) {
                setState(() {
                  _selectedReportType = newValue!;
                });
                _fetchDataForSelectedType(_selectedKlijent!);
              },
              items: <String>['Narudzbe', 'Clanska karta']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Odaberi tip reporta'),
            ),

            SizedBox(height: 32.0),

            // Prikaz sadržaja izvještaja
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: _buildContent(),
            ),

            SizedBox(height: 32.0),

            // Dugme za ispis izvještaja
            ElevatedButton(
              onPressed: () async {
                final pdf = await _generatePDFReport();
                await _printPDFReport(pdf);
              },
              child: Text('Save and Print Report'),
            ),
          ],
        ),
      ),
    ),
  );
}
}