import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xfit_admin/models/narudzba.dart';
import 'package:xfit_admin/providers/narudzba_provider.dart';
import 'package:xfit_admin/screens/order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersProvider _ordersProvider = OrdersProvider();
  List<Narudzba> _narudzba = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNarudzbe();
  }

  Future<void> _fetchNarudzbe() async {
    try {
      var result = await _ordersProvider.get();
      print(result.result);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240), // Zeleni background
        title: const Text('Orders'),
      ),
      body: Column(
        children: [
          _buildDataListView(),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    if (isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_narudzba.isEmpty) {
      return const Expanded(
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
                  onTap: () async {
                    var refresh = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderDetailScreen(narudzba: narudzba),
                      ),
                    );
                    if (refresh == 'reload') {
                      _fetchNarudzbe();
                    }
                  },
                  title: Text(narudzba.brojNarudzbe ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(narudzba.iznos.toString() ?? ''),
                      const SizedBox(height: 8),
                      Text(
                        'Created on: ${narudzba.datum != null ? DateFormat('yyyy-MM-dd').format(narudzba.datum!) : 'Unknown Date'}',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
