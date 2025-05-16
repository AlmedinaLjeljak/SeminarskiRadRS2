import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobilna/models/cart.dart';
import 'package:xfit_mobilna/providers/cart_provider.dart';
import 'package:xfit_mobilna/providers/korisnik_providder.dart';
import 'package:xfit_mobilna/providers/narudzba_provider.dart';
import 'package:xfit_mobilna/screens/payment_screen.dart';
import 'package:xfit_mobilna/utils/util.dart';
import 'package:xfit_mobilna/widgets/master_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

   double total = 0;
class _CartScreenState extends State<CartScreen> {
   late CartProvider _cartProvider;
   late OrdersProvider _orderProvider;
   late KorisnisiProvider _korisniciProvider;

@override
  void initState() {
    super.initState();
  }

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartProvider = context.watch<CartProvider>();
    _orderProvider = context.watch<OrdersProvider>();
    _korisniciProvider = context.watch<KorisnisiProvider>();
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Cart",
      child: Column(
        children: [
          Expanded(
          child : _cartProvider.cart.items.isNotEmpty
          ? _buildProductCardList()
          : Center(child: Text("Your cart is empty.")),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total : " + total.toString() + " KM",
                  style: TextStyle(fontSize: 18),
                ),
                _buildBuyButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildProductCardList() {
    return Container(
      child: ListView.builder(
        itemCount: _cartProvider.cart.items.length,
        itemBuilder: (context, index) {
          return _buildProductCard(_cartProvider.cart.items[index]);
        },
      ),
    );
  }
  Widget _buildProductCard(CartItem item) {
  return Row(
    children: [
      Container(
        width: 100,
        height: 100,
        child: imageFromBase64String(item.product.slika!),
      ),
      SizedBox(width: 10), 
      Expanded(
        child: ListTile(
          title: Text(item.product.naziv ?? ""),
          subtitle: Text(item.product.cijena.toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min, 
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  _cartProvider.decreaseQuantity(item.product);
                },
              ),
              Text(item.count.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _cartProvider.addToCart(item.product);
                },
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

  Future<int> getKlijentId() async {
      final klijenti = await _korisniciProvider.get(filter: {
        'korisnikUlogas': 'klijent',
      });

      final klijent = klijenti.result.firstWhere((korisnik) => korisnik.korisnickoIme== Authorization.username);

      return klijent.korisnikId!;
    }


  

   Future<String> getKlijentLastName() async {
      final klijenti = await _korisniciProvider.get(filter: {
        'korisnikUlogas': 'klijent',
      });

      final klijent = klijenti.result.firstWhere((korisnik) => korisnik.korisnickoIme == Authorization.username);

      return klijent.prezime!;
    }
Widget _buildBuyButton() {
  return TextButton(
    child: Text("Buy"),
    style: TextButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 168, 204, 235),
      foregroundColor: Colors.black,
    ),
    onPressed: _cartProvider.cart.items.isEmpty ? null : () async {
      List<Map<String, dynamic>> items = [];

      _cartProvider.cart.items.forEach((item) {
        items.add(
          {
            "proizvodId": item.product.proizvodId,
            "kolicina": item.count,
          },
        );
      });
      int klijentId = await getKlijentId();
      

      Map<String, dynamic> order = {
        "items": items,
         "korisnikId": await getKlijentId(),
      };

      var response = await _orderProvider.insert(order);
      
      setState(() {});

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            items: items,
            korisnikId: klijentId,
            narudzbaId: response.narudzbaId,
            iznos:response.iznos
          )),
      );
    },
  );
}
}