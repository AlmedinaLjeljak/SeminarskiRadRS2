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
  final int? selectedClient;

  TerminDetailScreen({this.termin, this.selectedClient});

  @override
  _TerminDetailScreenState createState() => _TerminDetailScreenState();
}

class _TerminDetailScreenState extends State<TerminDetailScreen> {
  late DateTime _modifiedDatum;
  int? _modifiedUposlenikId;
  int? _modifiedKlijentId;
  bool _isSaveButtonEnabled = false;

  late KorisnisiProvider _korisniciProvider;
  late TerminiProvider _terminiProvider;
  SearchResult<Korisnik>? _clientsResult;
  List<Termin>? _clientsAppointments;
  int? _selectedClient;

  bool get _isEditing => widget.termin != null;
  SearchResult<Termin>? _occupiedResult;

  @override
  void initState() {
    super.initState();
    _korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
    _terminiProvider = TerminiProvider();

    _modifiedDatum = widget.termin?.datum ?? DateTime.now();
    _modifiedUposlenikId = widget.termin?.korisnikIdUposlenik;
    _modifiedKlijentId = widget.selectedClient;

    _loadClients();
  }

  Future<void> _loadClients() async {
    final data = await _korisniciProvider.get(filter: {'korisnikUlogas': 'klijent'});
    setState(() {
      _clientsResult = data;
      _selectedClient = _modifiedKlijentId ?? (data.result.isNotEmpty ? data.result.first.korisnikId : null);
    });
    _loadClientsAppointments();
    _loadOccupied();
  }

  Future<void> _loadClientsAppointments() async {
    if (_selectedClient == null) return;
    final data = await _terminiProvider.get(filter: {'korisnikIdKlijent': _selectedClient});
    setState(() => _clientsAppointments = data.result);
  }

  Future<void> _loadOccupied() async {
    final data = await _terminiProvider.get(filter: {'datum': _modifiedDatum.toIso8601String()});
    setState(() => _occupiedResult = data);
  }

  bool _isDateTimeOccupied(DateTime dt) {
    if (_clientsAppointments == null) return false;
    for (var t in _clientsAppointments!) {
      final diff = t.datum!.difference(dt).inMinutes.abs();
      if (diff < 30) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Appointment' : 'Add Appointment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _sectionCard(
              title: 'Client',
              child: _buildClientDropdown(),
            ),
            const SizedBox(height: 16),
            _sectionCard(
              title: 'Date & Time',
              child: _buildDateSelector(),
            ),
            const SizedBox(height: 16),
            _sectionCard(
              title: 'Occupied Slots',
              child: _buildOccupiedList(),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _isSaveButtonEnabled ? _onSave : null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const Divider(height: 24),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildClientDropdown() {
    if (_clientsResult == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return DropdownButtonFormField<int>(
      value: _selectedClient,
      items: _clientsResult!.result.map((kor) {
        return DropdownMenuItem(
          value: kor.korisnikId,
          child: Text(kor.ime ?? ''),
        );
      }).toList(),
      onChanged: _isEditing ? null : (v) => setState(() => _selectedClient = v),
      decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
    );
  }

  Widget _buildDateSelector() {
    final formatted = DateFormat('dd.MM.yyyy - HH:mm').format(_modifiedDatum);
    final occupied = _isDateTimeOccupied(_modifiedDatum);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(formatted, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () async {
            final dt = await Navigator.of(context).push<DateTime>(
              MaterialPageRoute(builder: (_) => DateTest()),
            );
            if (dt != null) {
              setState(() {
                _modifiedDatum = dt;
                _isSaveButtonEnabled = true;
              });
              await _loadOccupied();
            }
          },
          icon: const Icon(Icons.calendar_today),
          label: const Text('Select Date & Time'),
        ),
        if (occupied)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('This slot is occupied',
                style: TextStyle(color: Colors.red[700])),
          ),
      ],
    );
  }

  Widget _buildOccupiedList() {
    final list = _occupiedResult?.result ?? [];
    if (list.isEmpty) {
      return const Text('No occupied slots.');
    }
    return Column(
      children: list.map((t) {
        return ListTile(
          dense: true,
          leading: const Icon(Icons.block, color: Colors.redAccent),
          title: Text(DateFormat('dd.MM.yyyy - HH:mm').format(t.datum!)),
        );
      }).toList(),
    );
  }

  void _onSave() async {
    if (_isDateTimeOccupied(_modifiedDatum)) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Conflict'),
          content: const Text('Selected slot is occupied.'),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        ),
      );
      return;
    }

    if (_isEditing) {
      widget.termin!
        ..datum = _modifiedDatum
        ..korisnikIdKlijent = _selectedClient;
      await _terminiProvider.update(widget.termin!.terminId!, widget.termin!);
      Navigator.pop(context, widget.termin);
    } else {
     
      final uposlenik = await _korisniciProvider.get(filter: {'korisnikUlogas': 'uposlenik'});
      final up = uposlenik.result.firstWhere((u) => u.korisnickoIme == Authorization.username).korisnikId!;
      final newTermin = Termin(null, _modifiedDatum, _selectedClient, up);
      final inserted = await _terminiProvider.insert(newTermin);
      Navigator.pop(context, inserted);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Appointment saved'), backgroundColor: Colors.green),
    );
  }
}
