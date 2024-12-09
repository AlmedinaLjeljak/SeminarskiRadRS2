import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'This is the Product List Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}