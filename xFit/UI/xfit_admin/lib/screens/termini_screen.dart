import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xfit_admin/models/termin.dart';
import 'package:xfit_admin/providers/termini_provider.dart';
import 'package:xfit_admin/screens/termin_detail_screen.dart';
import 'package:xfit_admin/utils/util.dart';

class TerminScreen extends StatefulWidget {
  const TerminScreen({Key? key}) : super(key: key);

  @override
  State<TerminScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminScreen> {
  final TerminiProvider _terminiProvider = TerminiProvider();
  List<Termin> _termin = [];
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
          'desktop': Authorization.username.toString(),
        },
      );
      setState(() {
        _termin = result.result;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240),
        title: Text('Appointments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: _buildDataListView()),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _navigateToTerminDetailScreen(null,null); 
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

    if (_termin.isEmpty) {
      return Text('No termini found.');
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
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Edit')),
              DataColumn(label: Text('Complete')),
            ],
            rows: _termin.map((termin) {
              return DataRow(
                cells: [
                  DataCell(Text(termin.uposlenikId.toString())),
                  DataCell(Text(termin.klijentId.toString())),
                  DataCell(Text(DateFormat('dd.MM.yyyy - HH:mm').format(termin.datumVrijeme!))),
                  DataCell(IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _navigateToTerminDetailScreen(termin,termin.klijentId);
                    },
                  )),
                  DataCell(IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      _showDeleteConfirmationDialog(termin);
                    },
                  )),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _navigateToTerminDetailScreen(Termin? termin, int? selectedKlijent) async {
    final modifiedTermin = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TerminDetailScreen(termin: termin, selectedKlijent: selectedKlijent),
      ),
    );

    if (modifiedTermin != null && modifiedTermin is Termin) {
      setState(() {
        int index = _termin.indexWhere((element) => element.terminId == modifiedTermin.terminId);
        if (index != -1) {
          _termin[index] = modifiedTermin;
        } else {
          _termin.add(modifiedTermin);
        }
      });
    }
  }


  void _showDeleteConfirmationDialog(Termin termin) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Is this appointment finished?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No, keep it'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteTermin(termin);
                Navigator.of(context).pop();
              },
              child: Text('Yes, delete it'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTermin(Termin termin) async {
    try {
      await _terminiProvider.delete(termin.terminId);
      setState(() {
        _termin.removeWhere((item) => item.terminId == termin.terminId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Appointment deleted successfully.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete appointment.'),
        ),
      );
    }
  }
}







