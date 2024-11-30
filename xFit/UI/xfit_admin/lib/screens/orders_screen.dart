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
  List<Narudzba> _narudzbe = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNarudzbe();
  }

  Future<void> _fetchNarudzbe() async {
    try {
      var result = await _ordersProvider.get();
      setState(() {
        _narudzbe = result.result;
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
        title: Text('Orders'),
        backgroundColor: const Color.fromARGB(255, 186, 231, 240), 
        centerTitle: false,  
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Total Orders: ${_narudzbe.length}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),
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

    if (_narudzbe.isEmpty) {
      return Expanded(
        child: Center(
          child: Text('No orders found.'),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: _narudzbe.length,
        itemBuilder: (context, index) {
          var narudzba = _narudzbe[index];
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
                        builder: (context) =>
                            OrderDetailScreen(),
                      ),
                    );
                    if (refresh == 'reload') {
                      _fetchNarudzbe();
                    }
                  },
                  title: Text('Order ${narudzba.brojNarudzbe ?? ''}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: ${(narudzba.iznos ?? 0).toStringAsFixed(2)} KM',
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Created on: ${narudzba.datum != null ? DateFormat('yyyy-MM-dd').format(narudzba.datum!) : 'Unknown Date'}',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
