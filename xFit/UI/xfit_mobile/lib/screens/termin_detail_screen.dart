import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobile/models/korisnik.dart';
import 'package:xfit_mobile/models/search_result.dart';
import 'package:xfit_mobile/models/termin.dart';
import 'package:xfit_mobile/providers/korisnik_providder.dart';
import 'package:xfit_mobile/providers/termini_provider.dart';
import 'package:xfit_mobile/screens/date_screen.dart';
import 'package:xfit_mobile/utils/util.dart';

class TerminDetailScreen extends StatefulWidget {
  final Termin? termin;

  TerminDetailScreen({this.termin});

  @override
  _TerminDetailScreenState createState() => _TerminDetailScreenState();
}

class _TerminDetailScreenState extends State<TerminDetailScreen> {
  late DateTime _modifiedDatum;
  int? _modifiedUposlenikId;
  late DateTime _initialDateTime;

  late KorisnisiProvider _korisniciProvider;
  late TerminiProvider _terminiProvider;
  SearchResult<Korisnik>? result;
  List<Termin>? _termini;
  int? _selectedUposlenik;

  bool _isDateModified = false;
  bool _isSaveButtonEnabled = false;

  SearchResult<Termin>? terminiResult;

  @override
  void initState() {
    super.initState();
    _korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
    _terminiProvider = TerminiProvider();

    _modifiedDatum = widget.termin?.datumVrijeme ?? DateTime.now();
    _modifiedUposlenikId = widget.termin?.uposlenikId;

    _initialDateTime = _modifiedDatum;

    _fetchKlijenti();
    _fetchTerminiForKlijent();
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

  Future<void> _fetchKlijenti() async {
    try {
      var data = await _korisniciProvider.get(filter: {
        'korisnikUlogas': 'klijent',
      });

      setState(() {
        result = data;
        if (result?.result.isNotEmpty == true) {
          _selectedUposlenik = _modifiedUposlenikId ?? result!.result[0].korisnikId;
        } else {
          _selectedUposlenik = null;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchTerminiForKlijent() async {
    try {
      var terminiData = await _terminiProvider.get();
      setState(() {
        _termini = terminiData.result;
      });
    } catch (e) {
      print(e);
    }
  }

  bool _isDateTimeOccupied(DateTime dateTime) {
    if (_termini != null) {
      for (var termin in _termini!) {
        if (termin.datumVrijeme == dateTime) {
          return true;
        }
      }
    }
    return false;
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Appointment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              DropdownButton<int>(
                value: _selectedUposlenik,
                onChanged: (newValue) {
                  setState(() {
                    _selectedUposlenik = newValue!;
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
                  _selectedUposlenik != null
                      ? 'Selected Uposlenik ID: $_selectedUposlenik'
                      : 'Select a Uposlenik',
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

                    if(terminDatum!=null && terminDatum is DateTime)
                    {
                      print("Test");
                    print((terminDatum as DateTime).toIso8601String());

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
                            _saveNewTermin();
                          }
                        : null,
                    child: Text('Save'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    (terminiResult == null || terminiResult!.result.isEmpty)
                        ? Text('No occupied appointments')
                        : Text('Occupied appointments')
                  ],
                ),
              ),
              
              Expanded(
                child: 
                 (terminiResult == null || terminiResult!.result.isEmpty) ? Container() :
               ListView.builder(
                    itemCount: terminiResult!.result.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(terminiResult!.result[index].datumVrijeme.toString(),
                           
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
    );
  }

  void _saveNewTermin() async {
    if (_termini == null) {
      return;
    }

 
    Future<int?> getKlijentId() async {
  try {
    final klijenti = await _korisniciProvider.get(filter: {
      'korisnikUlogas': 'klijent',
    });

  
    if (klijenti.result.isNotEmpty) {
      
      return klijenti.result[0].korisnikId;
    } else {
     
      return null;
    }
  } catch (e) {
    print("Error fetching klijent: $e");
    return null;
  }
}


    final klijent = await getKlijentId();
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
        _selectedUposlenik,
        klijent,
        
      );

      try {
        if (_isDateTimeOccupied(_modifiedDatum)) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Date and Time Occupied'),
                content:
                    Text('The selected date and time are already occupied.'),
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
          final insertedTermin = await TerminiProvider().insert(newTermin);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Appointment successfully added.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, insertedTermin);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}