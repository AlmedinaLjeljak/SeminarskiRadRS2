import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xfit_mobile/models/termin.dart';
import 'package:xfit_mobile/providers/termini_provider.dart';
import 'package:xfit_mobile/screens/termin_detail_screen.dart';
import 'package:xfit_mobile/utils/util.dart';
import 'package:xfit_mobile/widgets/master_screen.dart';

class TerminScreen extends StatefulWidget {
  const TerminScreen({Key? key}) : super(key: key);

  @override
  _TerminiScreenState createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminScreen> {
  final TerminiProvider _terminiProvider = TerminiProvider();
  List<Termin> _termini = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTermini();
  }

  Future<void> _fetchTermini() async {
    try {
      var result = await _terminiProvider.get(
        filter: {
          'uposlenik': Authorization.username.toString(),
        },
      );
      setState(() {
        _termini = result.result;
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
      
        title_widget: Text('Appointments'),
      
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: _buildDataListView()),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToTerminDetailScreen(null); 
              },
              child: Text('Add Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataListView() {
    if (isLoading) {
      return CircularProgressIndicator();
    }

    if (_termini.isEmpty) {
      return Text('There are no appointments.');
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Uposlenik')),
              DataColumn(label: Text('Klijent')),
              DataColumn(label: Text('Appointment Date')),
            ],
            rows: _termini.map((termin) {
              return DataRow(
                cells: [
                  DataCell(Text(termin.uposlenikId.toString())),
                  DataCell(Text(termin.klijentId.toString())),
                  DataCell(Text(DateFormat('dd.MM.yyyy - HH:mm').format(termin.datumVrijeme!))),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _navigateToTerminDetailScreen(Termin? termin) async {
    final modifiedTermin = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TerminDetailScreen(termin:termin ),
      ),
    );

    if (modifiedTermin != null && modifiedTermin is Termin) {
      setState(() {
        int index = _termini.indexWhere((element) => element.terminId == modifiedTermin.terminId);
        if (index != -1) {
          _termini[index] = modifiedTermin;
        } else {
          _termini.add(modifiedTermin);
        }
      });
    }
  }
}
