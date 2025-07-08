import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobilna/main.dart';
import 'package:xfit_mobilna/models/korisnik.dart';
import 'package:xfit_mobilna/providers/korisnik_providder.dart';
import 'package:xfit_mobilna/screens/cart_screen.dart';
import 'package:xfit_mobilna/screens/home_page_screen.dart';
import 'package:xfit_mobilna/screens/my_profile_screen.dart';
import 'package:xfit_mobilna/screens/narudzba_screen.dart';
import 'package:xfit_mobilna/screens/omiljeni_proizvod_screen.dart';
import 'package:xfit_mobilna/screens/product_list_screen.dart';
import 'package:xfit_mobilna/screens/termin_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  final Widget? child;
  final String? title;
  final Widget? title_widget;
  final bool showBackButton;

  MasterScreenWidget({
    this.child,
    this.title,
    this.title_widget,
    this.showBackButton = true,
    Key? key,
  }) : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 154, 222, 235),
        title: widget.title_widget ?? Text(widget.title ?? ""),
        actions: [
          if (widget.showBackButton)
            TextButton.icon(
              onPressed: () {
                if (!ModalRoute.of(context)!.isFirst) {
                  Navigator.pop(context, 'reload2');
                }
              },
           
              label: const Text(
                "",
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 154, 222, 235), 
          child: ListView(
            children: [
              ListTile(
                title: const Text('My profile'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyProfileScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Home page'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePageScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Products'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProductListScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Orders'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>const OrdersScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Appointments'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TerminiScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Cart'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Favorites'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FavoritesScreen(),
                    ),
                  );
                },
              ),
            
              ListTile(
                title: const Text('Log Out'),
                onTap: () {
                  final korisniciProvider =
                      Provider.of<KorisnisiProvider>(context, listen: false);
                  korisniciProvider.logout();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: widget.child,
    );
  }
}

