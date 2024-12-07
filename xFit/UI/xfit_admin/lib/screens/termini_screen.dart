/*import 'package:flutter/material.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class TerminiScreen extends StatefulWidget{
  const TerminiScreen({Key?key}):super(key:key);


@override
State<TerminiScreen> createState()=>_TerminiScreenState();

}

class _TerminiScreenState extends State<TerminiScreen>{
  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      title_widget: Text("Appointments"),
      child: Text("TerminiScreenHehe"),
    );
  }
  
}*/




import 'package:flutter/material.dart';
import 'package:xfit_admin/models/termin.dart';
import 'package:xfit_admin/providers/termini_provider.dart';
import 'package:provider/provider.dart';

class TerminScreen extends StatefulWidget {
  @override
  _TerminScreenState createState() => _TerminScreenState();
}

class _TerminScreenState extends State<TerminScreen> {
  late TerminiProvider _terminProvider;
  List<Termin> termini = [];

  @override
  void initState() {
    super.initState();
    _terminProvider = context.read<TerminiProvider>();
    _loadTermini();
  }

  Future<void> _loadTermini() async {
    try {
      final searchResult = await _terminProvider.get();
      setState(() {
        termini = searchResult.result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error loading termini: $e")));
    }
  }

  void _editTermin(Termin termin) {
    // Open edit form for the termin
    print("Editing termin: ${termin.terminId}");
  }

  Future<void> _deleteTermin(int terminId) async {
    try {
      await _terminProvider.delete(terminId);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Termin deleted")));
      _loadTermini();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error deleting termin: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Termini"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DataTable(
          columns: const [
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("Datum i Vrijeme")),
            DataColumn(label: Text("Akcije")),
          ],
          rows: termini.map((termin) {
            return DataRow(cells: [
              DataCell(Text(termin.terminId?.toString() ?? "-")),
              DataCell(
                Text(termin.datumVrijeme != null
                    ? "${termin.datumVrijeme}"
                    : "-"),
              ),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editTermin(termin),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTermin(termin.terminId!),
                    ),
                  ],
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add new termin
          print("Adding new termin");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
