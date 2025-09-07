import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xfit_mobilna/models/korisnik.dart';
import 'package:xfit_mobilna/models/termin.dart';
import 'package:xfit_mobilna/providers/korisnik_providder.dart';
import 'package:xfit_mobilna/providers/termini_provider.dart';
import 'package:xfit_mobilna/screens/termin_detail_screen.dart';
import 'package:xfit_mobilna/screens/termin_info_screen.dart';
import 'package:xfit_mobilna/widgets/master_screen.dart';

class TerminiScreen extends StatefulWidget {
  const TerminiScreen({Key? key}) : super(key: key);

  @override
  _TerminiScreenState createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
  final TerminiProvider _terminiProvider = TerminiProvider();
  final KorisnisiProvider _korisniciProvider = KorisnisiProvider();
  List<Termin> _termini = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTermini();
  }

  Future<void> _fetchTermini() async {
    try {
      var result = await _terminiProvider.get(); // bez filtera
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

  Future<Korisnik?> _fetchKorisnik(int? korisnikId) async {
    if (korisnikId == null) return null;
    try {
      return await _korisniciProvider.getById(korisnikId);
    } catch (e) {
      print("Greška pri dohvaćanju korisnika: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Appointments',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _termini.isEmpty
                      ? Center(child: Text('There are no appointments.'))
                      : ListView.separated(
                          itemCount: _termini.length,
                          separatorBuilder: (context, index) =>
                              Divider(height: 16),
                          itemBuilder: (context, index) {
                            final termin = _termini[index];
                            return FutureBuilder(
                              future: Future.wait([
                                _fetchKorisnik(termin.korisnikIdUposlenik),
                                _fetchKorisnik(termin.korisnikIdKlijent),
                              ]),
                              builder: (context,
                                  AsyncSnapshot<List<Korisnik?>> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                final uposlenik = snapshot.data![0];
                                final klijent = snapshot.data![1];

                                // provjera da li je termin prošao
                                bool isPast = termin.datum != null &&
                                    termin.datum!.isBefore(DateTime.now());

                                return Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color:
                                          isPast ? Colors.grey : Colors.green,
                                      width: 2,
                                    ),
                                  ),
                                  color: isPast ? Colors.grey[200] : Colors.white,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(16),
                                    title: Text(
                                      'Uposlenik: ${uposlenik != null ? "${uposlenik.ime} ${uposlenik.prezime}" : "Unknown"}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isPast ? Colors.grey : Colors.black,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8),
                                        Text(
                                          'Klijent: ${klijent != null ? "${klijent.ime} ${klijent.prezime}" : "Unknown"}',
                                          style: TextStyle(
                                              color: isPast
                                                  ? Colors.grey
                                                  : Colors.black87),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              isPast
                                                  ? Icons.check_circle
                                                  : Icons.access_time,
                                              color: isPast
                                                  ? Colors.red
                                                  : Colors.green,
                                              size: 18,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              termin.datum != null
                                                  ? DateFormat('dd.MM.yyyy - HH:mm')
                                                      .format(termin.datum!)
                                                  : 'Nepoznat datum',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: isPast
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.info,
                                          color: Colors.blue),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TerminInfoScreen(termin: termin),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToTerminDetailScreen(null);
                },
                child: Text('Add Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToTerminDetailScreen(Termin? termin) async {
    final modifiedTermin = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TerminDetailScreen(termin: termin),
      ),
    );

    if (modifiedTermin != null && modifiedTermin is Termin) {
      setState(() {
        int index = _termini.indexWhere(
            (element) => element.terminId == modifiedTermin.terminId);
        if (index != -1) {
          _termini[index] = modifiedTermin;
        } else {
          _termini.add(modifiedTermin);
        }
      });
    }
  }
}
