import 'package:flutter/material.dart';
import 'package:xfit_mobilna/screens/cash_on_delivery_screen.dart';

import 'package:xfit_mobilna/screens/payment_screen.dart';


class PaymentMethodScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int korisnikId;
  final int narudzbaId;
  final double iznos;

  const PaymentMethodScreen({
    Key? key,
    required this.items,
    required this.korisnikId,
    required this.narudzbaId,
    required this.iznos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Način plaćanja")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Plaćanje pouzećem
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>CashOnDeliveryScreen (
                      items: items,
                      korisnikId: korisnikId,
                      narudzbaId: narudzbaId,
                      iznos: iznos,
                    
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.local_shipping),
              label: const Text("Plaćanje pouzećem"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Plaćanje PayPal-om
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                      items: items,
                      korisnikId: korisnikId,
                      narudzbaId: narudzbaId,
                      iznos: iznos,
                      
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.account_balance_wallet),
              label: const Text("Plaćanje PayPal-om"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
