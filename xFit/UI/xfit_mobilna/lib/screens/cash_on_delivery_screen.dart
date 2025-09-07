// cash_on_delivery_screen.dart
import 'package:flutter/material.dart';
import 'narudzba_screen.dart'; // OrdersScreen

class CashOnDeliveryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final int korisnikId;
  final int narudzbaId;
  final double iznos;

  const CashOnDeliveryScreen({
    Key? key,
    required this.items,
    required this.korisnikId,
    required this.narudzbaId,
    required this.iznos,
  }) : super(key: key);

  @override
  State<CashOnDeliveryScreen> createState() => _CashOnDeliveryScreenState();
}

class _CashOnDeliveryScreenState extends State<CashOnDeliveryScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _imePrezimeController = TextEditingController();
  final TextEditingController _pptController = TextEditingController();
  final TextEditingController _gradController = TextEditingController();
  final TextEditingController _ulicaBrojController = TextEditingController();
  final TextEditingController _mobitelController = TextEditingController();
  final TextEditingController _napomenaController = TextEditingController();

  bool _saglasnost = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preuzimanje poštom"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Vraća se na PaymentMethodScreen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _imePrezimeController,
                decoration: const InputDecoration(
                  labelText: "Ime i prezime",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Unesite ime i prezime" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _pptController,
                decoration: const InputDecoration(
                  labelText: "PPT",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _gradController,
                decoration: const InputDecoration(
                  labelText: "Grad",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Unesite grad" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ulicaBrojController,
                decoration: const InputDecoration(
                  labelText: "Ulica i broj",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Unesite ulicu i broj" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _mobitelController,
                decoration: const InputDecoration(
                  labelText: "Mobitel",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? "Unesite broj mobitela" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _napomenaController,
                decoration: const InputDecoration(
                  labelText: "Napomena",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text(
                  "Saglasan/a sam sa pravilnikom",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                value: _saglasnost,
                onChanged: (val) => setState(() => _saglasnost = val!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (!_saglasnost) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Morate se saglasiti sa pravilnikom da nastavite."),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Narudžba uspješno potvrđena!"),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Ide na OrdersScreen nakon potvrde
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersScreen(),
                        ),
                      );
                    });
                  }
                },
                child: const Text("Potvrdi i pošalji"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
