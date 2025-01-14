import 'dart:convert';

import 'package:xfit_mobile/models/korisnik.dart';
import 'package:xfit_mobile/models/transakcija.dart';
import 'package:xfit_mobile/providers/korisnik_providder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:provider/provider.dart';

import '../models/TransakcijaUpsertRequest.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../providers/transakcija_provider.dart';
import 'package:http/http.dart' as http;

import '../utils/util.dart';
import 'cart_screen.dart';

class PaymentScreen extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final int korisnikId;
  final int? narudzbaId; 
  final double? iznos;


  PaymentScreen({required this.items, required this.korisnikId, required this.narudzbaId, required this.iznos, super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late List<Map<String, dynamic>> itemList = [];
  late ProductProvider _productProvider;
  late TransakcijaProvider _transakcijaProvider;
   late CartProvider _cartProvider;



  @override
  void initState() {
    super.initState();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _transakcijaProvider = Provider.of<TransakcijaProvider>(context, listen: false);
    _cartProvider = Provider.of<CartProvider>(context, listen: false);

   
    _navigateToPaypalCheckout();

  }

void _navigateToPaypalCheckout() async {
  double totalAmount = await calculateTotalAmount(widget.items); 
  await buildItemList(widget.items);

  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (BuildContext context) => PaypalCheckout(
      sandboxMode: true,
      clientId: "AYqgdtH-gUKuOl9r8gp1N30W2xgy-JZ9RDnGAZDRm4iaRwZImdqOyUpQ7A4eUokrmjP2B8iYNig4zfP-",
      secretKey: "ECnpPQaBicOGu5NdB6yLqbK4GxlmC1aDbIYtVKfNtg9ukliMqVKc3wAsoSgNaiNsDay8EdHG2sE6XjiQ",
      returnURL: "return.example.com",
      cancelURL: "cancel.example.com",
      transactions: [
        {
          "amount": {
            "total": totalAmount.toStringAsFixed(2), 
            "currency": "USD",
            "details": {
              "subtotal": totalAmount.toStringAsFixed(2),
              "shipping": '0',
              "shipping_discount": 0,
            },
          },
          "description": "The payment transaction description.",
         
          "item_list": {"items": itemList},
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        print("onSuccess: $params");
      if (params['data']['state'] == 'approved') {

       Transakcija request = Transakcija(
        null,
        widget.narudzbaId,
        widget.iznos
        
        );
  await _transakcijaProvider.insert(request);

  _cartProvider.cart.items.clear();
      total = 0.00;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order has been processed.'),
              backgroundColor: Colors.green,
            ),
          );
         // Navigator.pop(context, 'reload');
      }else{
        print('Payment was not successful');
      }
      },
      onError: (error) {
        print("onError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        print('Payment canceled');
      },
    ),
  ));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
      ),
    );
  }

Future<double> calculateTotalAmount(List<Map<String, dynamic>> items) async {
  double total = 0.0;

    for (var item in items) {
      int proizvodId = item["proizvodId"];
      int quantity = item["kolicina"];

      final product = await _productProvider.getById(proizvodId);

      if (product != null) {
        double price = product.cijena ?? 0.0;
        total += price * quantity;
      }
    }

  return total;
}


  Future<void> buildItemList(List<Map<String, dynamic>> items) async {
    itemList.clear();
    print(items.length.toString());

    double totalAmount = await calculateTotalAmount(items);

    for (var i = 0; i < items.length; i++) {
      if (i < items.length) {
        int proizvodId = items[i]["proizvodId"];
        final product = await _productProvider.getById(proizvodId);
        if (product != null) {
          String productName = product.naziv!;
          int quantity = items[i]["kolicina"];
          double price = product.cijena!;
          totalAmount += price * quantity;
          itemList.add({
            "name": productName,
            "quantity": quantity,
            "price": price.toStringAsFixed(2),
            "currency": "USD",
          });
          print(itemList);
        }
      } else {
      }
    }

    print("Total Amount: $totalAmount");
  }
}