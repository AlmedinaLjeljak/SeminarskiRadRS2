import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobilna/models/narudzba.dart';
import 'package:xfit_mobilna/providers/korisnik_providder.dart';
import 'package:xfit_mobilna/providers/narudzba_provider.dart';
import 'package:xfit_mobilna/widgets/master_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersProvider _ordersProvider = OrdersProvider();
  late KorisnisiProvider _korisniciProvider;

  List<Narudzba> _narudzba = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
    _fetchNarudzbe();
  }

  Future<void> _fetchNarudzbe() async {
    try {
      var result = await _ordersProvider.get(); 
      setState(() {
        _narudzba = result.result;
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
      
        title_widget: Text('Orders'),
      
      child: Column(
        children: [
          _buildDataListView(),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    if (isLoading) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_narudzba.isEmpty) {
      return Expanded(
        child: Center(
          child: Text('No orders found.'),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: _narudzba.length,
        itemBuilder: (context, index) {
          var narudzba = _narudzba[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(narudzba.brojNarudzbe ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(narudzba.iznos.toString()),
                      SizedBox(height: 8),
                      Text(
                        'Created on: ${narudzba.datum != null ? DateFormat('yyyy-MM-dd').format(narudzba.datum!) : 'Unknown Date'}',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: _getStatusColor(narudzba.status),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      narudzba.status ?? 'Unknown Status',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _getStatusColor(String? status) {
    if (status == 'Pending') {
      return Colors.orange;
    } else if (status == 'Completed') {
      return Colors.green;
    } else if (status == 'Cancelled') {
      return Colors.red;
    }
    return Colors.grey;
  }
}
