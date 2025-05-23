import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/korisnik.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/models/termin.dart';
import 'package:xfit_admin/providers/korisnici_provider.dart';
import 'package:xfit_admin/providers/termini_provider.dart';
import 'package:xfit_admin/screens/date_screen.dart';
import 'package:xfit_admin/utils/util.dart';


class TerminDetailScreen extends StatefulWidget {
  final Termin? termin;
  final int? selectedKlijent;

  TerminDetailScreen({this.termin, this.selectedKlijent});

  @override
  _TerminDetailScreenState createState() =>
      _TerminDetailScreenState();
}

class _TerminDetailScreenState extends State<TerminDetailScreen> {
  late DateTime _modifiedDatum;
  int? _modifiedUposlenikId;
  int? _modifiedKlijentId;

  bool _isDateModified = false;
  bool _isSaveButtonEnabled = false;

  late KorisnisiProvider _korisniciProvider;
  late TerminiProvider _terminiProvider;
  SearchResult<Korisnik>? result;
  List<Termin>? _termini;
  int? _selectedKlijent;

  bool get _isEditing => widget.termin != null;

  SearchResult<Termin>? terminiResult;

  @override
  void initState() {
    super.initState();
    _korisniciProvider =
        Provider.of<KorisnisiProvider>(context, listen: false);
    _terminiProvider = TerminiProvider();

    _modifiedDatum = widget.termin?.datum ?? DateTime.now();
    _modifiedUposlenikId = widget.termin?.korisnikIdUposlenik;
    _modifiedKlijentId = widget.selectedKlijent ?? null;

    _fetchKlijenti();
    _fetchTerminiForKlijent(_selectedKlijent ?? _modifiedKlijentId ?? -1);
    _fetchOcuppiedAppointments();
  }

  Future<void> _fetchOcuppiedAppointments() async {
    try {
      var data = await _terminiProvider.get(filter: {
        'datumVrijeme': _modifiedDatum.toIso8601String(),
      });

      setState(() {
        terminiResult = data;
      });
    } catch (e) {
      print(e);
    }
  }

  bool _isDateTimeOccupied(DateTime dateTime) {
    if (_termini != null) {
      for (var termin in _termini!) {
        if (dateTime.isBefore(termin.datum!.add(Duration(minutes: 30))) &&
            termin.datum!.isBefore(dateTime.add(Duration(minutes: 30)))) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> _fetchKlijenti() async {
    try {
      var data = await _korisniciProvider.get(filter: {
        'korisnikUloga': 'klijent',
      });

      setState(() {
        result = data;
        if (result?.result.isNotEmpty == true) {
          _selectedKlijent = _modifiedKlijentId ?? result!.result[0].korisnikId;
        } else {
          _selectedKlijent = null;
        }
      });
    } catch (e) {
      print(e);
    }
  }
    Future<int?> getUposlenikId() async {
  try {
    final korisnici = await _korisniciProvider.get(filter: {
      'korisnickoIme': 'desktop', 
    });

    if (korisnici.result.isEmpty) {
      print('Korisnik sa korisničkim imenom "desktop" nije pronađen.');
      return null;
    }

    final korisnik = korisnici.result.first;
    return korisnik.korisnikId;
  } catch (e) {
    print('Greška pri preuzimanju ID-a ulogovanog korisnika: $e');
    return null;
  }
}

  Future<void> _fetchTerminiForKlijent(int klijentId) async {
    try {
      var terminiData = await _terminiProvider.get(filter: {
        'korisnikIdKlijent': klijentId,
      });
      setState(() {
        _termini = terminiData.result;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Appointment' : 'Add Appointment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  DropdownButton<int>(
                    value: _selectedKlijent,
                    onChanged: _isEditing
                        ? null
                        : (newValue) {
                            setState(() {
                              _selectedKlijent = newValue!;
                            });
                          },
                    items: result?.result
                            .map<DropdownMenuItem<int>>((Korisnik korisnik) {
                          return DropdownMenuItem<int>(
                            value: korisnik.korisnikId,
                            child: Text(korisnik.ime!),
                          );
                        }).toList() ??
                        [],
                    isExpanded: true,
                    disabledHint: Text(
                      _selectedKlijent != null
                          ? 'Selected Klijent ID: $_selectedKlijent'
                          : 'Select a Klijent',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Date:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    DateFormat('dd.MM.yyyy - HH:mm').format(_modifiedDatum),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
ElevatedButton(
  onPressed: () async {
    var terminDatum = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DateTest(),
      ),
    );

    if (terminDatum != null && terminDatum is DateTime) {
      setState(() {
        _modifiedDatum = terminDatum;
        _isDateModified = true;
        _isSaveButtonEnabled = true;
      });

      await _fetchOcuppiedAppointments();
    }
  },
  child: Text('Select Date and Time'),
),


                      ElevatedButton(
                        onPressed: _isSaveButtonEnabled
                            ? () {
                                if (_isEditing) {
                                  _saveModifiedTermin();
                                } else {
                                  _saveNewTermin();
                                }
                              }
                            : null,
                        child: Text('Save'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        (terminiResult == null ||
                                terminiResult!.result.isEmpty)
                            ? Text('No occupied appointments')
                            : Text('Occupied appointments')
                      ],
                    ),
                  ),
                  Expanded(
                    child: (terminiResult == null ||
                            terminiResult!.result.isEmpty)
                        ? Container()
                        : ListView.builder(
                            itemCount: terminiResult!.result.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
  DateFormat('dd.MM.yyyy - HH:mm').format(terminiResult!.result[index].datum!),
),

                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  )
                                ],
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveModifiedTermin() async {
    final selectedDateTime = _modifiedDatum;

    if (_isDateTimeOccupied(selectedDateTime)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Date and Time Occupied'),
            content: Text('The selected date and time are already occupied.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      widget.termin!.datum = _modifiedDatum;
      widget.termin!.korisnikIdUposlenik = _modifiedUposlenikId;
      widget.termin!.korisnikIdKlijent = _modifiedKlijentId;

      try {
        await TerminiProvider()
            .update(widget.termin!.terminId!, widget.termin!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Appointment successfully updated.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, widget.termin);
      } catch (e) {
        print(e);
      }
    }
  }

 void _saveNewTermin() async {
    final uposlenikId = await getUposlenikId();

    if (uposlenikId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to fetch your ID or role is not valid.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final selectedDateTime = _modifiedDatum;

    if (_isDateTimeOccupied(selectedDateTime)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Date and Time Occupied'),
            content: Text('The selected date and time are already occupied.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      final newTermin = Termin(
        null,
        _modifiedDatum,
        _selectedKlijent,
        uposlenikId,
      );

      try {
        final insertedTermin = await TerminiProvider().insert(newTermin);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Appointment successfully added.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, insertedTermin);
      } catch (e) {
        print(e);
      }
    }
  }}