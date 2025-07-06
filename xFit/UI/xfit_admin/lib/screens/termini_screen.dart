
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xfit_admin/models/klijent.dart';
import 'package:xfit_admin/models/korisnik.dart';
import 'package:xfit_admin/models/termin.dart';
import 'package:xfit_admin/providers/korisnici_provider.dart';
import 'package:xfit_admin/providers/termini_provider.dart';
import 'package:xfit_admin/screens/termin_detail_screen.dart';
import 'package:xfit_admin/utils/util.dart';



class TerminiScreen extends StatefulWidget {
  const TerminiScreen({Key? key}) : super(key: key);

  @override
  State<TerminiScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
  final TerminiProvider _terminiProvider = TerminiProvider();
  final KorisnisiProvider _korisniciProvider = KorisnisiProvider();

  List<Termin> _termini = [];
  List<Termin> _filteredTermini = [];
  Map<int, Korisnik> _korisniciMap = {};
  bool _isLoading = true;

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadTermini();
  }

  Future<void> _loadTermini() async {
    try {
      final result = await _terminiProvider.get(filter: {
        'desktop': Authorization.username,
      });

      _termini = result.result;

      await _loadKorisniciForTermini(_termini);

      _applyFilter();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadKorisniciForTermini(List<Termin> termini) async {
    final ids = <int>{};
    for (var t in termini) {
      if (t.korisnikIdUposlenik != null) ids.add(t.korisnikIdUposlenik!);
      if (t.korisnikIdKlijent != null) ids.add(t.korisnikIdKlijent!);
    }

    for (var id in ids) {
      try {
        final korisnik = await _korisniciProvider.getById(id);
        if (korisnik != null) {
          _korisniciMap[id] = korisnik;
        }
      } catch (e) {
        print('Greška pri dohvaćanju korisnika id=$id: $e');
      }
    }
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredTermini = List.from(_termini);
    } else {
      final query = _searchQuery.toLowerCase();
      _filteredTermini = _termini.where((t) {
        final uposlenik = _korisniciMap[t.korisnikIdUposlenik];
        final klijent = _korisniciMap[t.korisnikIdKlijent];

        final uposlenikImePrezime = uposlenik != null
            ? '${uposlenik.ime} ${uposlenik.prezime}'.toLowerCase()
            : '';
        final klijentImePrezime = klijent != null
            ? '${klijent.ime} ${klijent.prezime}'.toLowerCase()
            : '';

        return uposlenikImePrezime.contains(query) || klijentImePrezime.contains(query);
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240),
        title: const Text('Appointments'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search by  name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      _searchQuery = value;
                      _applyFilter();
                    },
                  ),
                ),
                Expanded(
                  child: _filteredTermini.isEmpty
                      ? const Center(child: Text('No appointments found.'))
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredTermini.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (ctx, i) => _buildCard(_filteredTermini[i]),
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateDetail(null),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCard(Termin t) {
    final uposlenik = _korisniciMap[t.korisnikIdUposlenik];
    final klijent = _korisniciMap[t.korisnikIdKlijent];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Uposlenik: ${uposlenik != null ? '${uposlenik.ime} ${uposlenik.prezime}' : 'Unknown'}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Klijent: ${klijent != null ? '${klijent.ime} ${klijent.prezime}' : 'Unknown'}',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd.MM.yyyy – HH:mm').format(t.datum!),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Edit',
              icon: const Icon(Icons.edit, color: Colors.blueGrey),
              onPressed: () => _navigateDetail(t),
            ),
            IconButton(
              tooltip: 'Mark Complete',
              icon: const Icon(Icons.check_circle, color: Colors.green),
              onPressed: () => _confirmDelete(t),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateDetail(Termin? t) async {
    final modified = await Navigator.of(context).push<Termin>(
      MaterialPageRoute(
        builder: (_) => TerminDetailScreen(
          termin: t,
          selectedClient: t?.korisnikIdKlijent,
        ),
      ),
    );
    if (modified != null) {
      setState(() {
        final idx = _termini.indexWhere((x) => x.terminId == modified.terminId);
        if (idx != -1) {
          _termini[idx] = modified;
        } else {
          _termini.add(modified);
        }
      });
      _applyFilter();  }
  }

  void _confirmDelete(Termin t) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Complete Appointment?'),
        content: const Text('Mark this appointment as completed (and remove)?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteTermin(t);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteTermin(Termin t) async {
    try {
      await _terminiProvider.delete(t.terminId);
      setState(() => _termini.removeWhere((x) => x.terminId == t.terminId));
      _applyFilter();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment completed.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to complete appointment.')),
      );
    }
  }
}



