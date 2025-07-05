import 'package:flutter/material.dart';
import 'package:xfit_admin/models/transakcija.dart';
import 'package:xfit_admin/providers/transakcija_provider.dart';

class TransakcijeScreen extends StatefulWidget {
  const TransakcijeScreen({Key? key}) : super(key: key);

  @override
  State<TransakcijeScreen> createState() => _TransakcijeScreenState();
}

class _TransakcijeScreenState extends State<TransakcijeScreen> {
  final TransakcijaProvider _transakcijaProvider = TransakcijaProvider();
  List<Transakcija> _transakcije = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransakcije();
  }

  Future<void> _fetchTransakcije() async {
    try {
      var data = await _transakcijaProvider.get();
      setState(() {
        _transakcije = data.result;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching transactions: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  DataRow _buildDataRow(Transakcija t) {
    return DataRow(cells: [
      DataCell(Text(t.narudzbaId?.toString() ?? "")),
      DataCell(Text(t.iznos?.toStringAsFixed(2) ?? "")),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240),
        title: const Text("Transactions"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey[300]!,
                        ),
                        columnSpacing: 50,
                        columns: const [
                          DataColumn(label: Text("Order ID")),
                          DataColumn(label: Text("Amount")),
                        ],
                        rows: _transakcije.map((t) => _buildDataRow(t)).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
