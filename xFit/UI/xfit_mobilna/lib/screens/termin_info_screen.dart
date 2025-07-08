import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xfit_mobilna/models/korisnik.dart';
import 'package:xfit_mobilna/models/termin.dart';
import 'package:xfit_mobilna/providers/korisnik_providder.dart';

class TerminInfoScreen extends StatefulWidget {
  final Termin termin;

  const TerminInfoScreen({Key? key, required this.termin}) : super(key: key);

  @override
  State<TerminInfoScreen> createState() => _TerminInfoScreenState();
}

class _TerminInfoScreenState extends State<TerminInfoScreen> {
  final KorisnisiProvider _korisniciProvider = KorisnisiProvider();
  Korisnik? uposlenik;
  Korisnik? klijent;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadKorisnici();
  }

  Future<void> _loadKorisnici() async {
    try {
      final fetchedUposlenik =
          await _korisniciProvider.getById(widget.termin.korisnikIdUposlenik!);
      final fetchedKlijent =
          await _korisniciProvider.getById(widget.termin.korisnikIdKlijent!);
      setState(() {
        uposlenik = fetchedUposlenik;
        klijent = fetchedKlijent;
        _loading = false;
      });
    } catch (e) {
      print('Greška kod učitavanja korisnika: $e');
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final datum = widget.termin.datum != null
        ? DateFormat('dd.MM.yyyy').format(widget.termin.datum!)
        : 'Nepoznat datum';

    final vrijeme = widget.termin.datum != null
        ? DateFormat('HH:mm').format(widget.termin.datum!)
        : 'Nepoznato vrijeme';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      Icons.person_outline,
                      'Klijent:',
                      klijent != null
                          ? "${klijent!.ime} ${klijent!.prezime}"
                          : 'Nepoznat',
                    ),
                    _buildDetailRow(
                      Icons.person,
                      'Uposlenik:',
                      uposlenik != null
                          ? "${uposlenik!.ime} ${uposlenik!.prezime}"
                          : 'Nepoznat',
                    ),
                    _buildDetailRow(
                      Icons.date_range,
                      'Date:',
                      datum,
                    ),
                    _buildDetailRow(
                      Icons.access_time,
                      'Time:',
                      vrijeme,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                      text: '$title ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
