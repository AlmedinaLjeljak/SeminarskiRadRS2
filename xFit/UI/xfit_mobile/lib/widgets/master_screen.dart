import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobile/main.dart';
import 'package:xfit_mobile/providers/korisnik_providder.dart';
import 'package:xfit_mobile/screens/cart_screen.dart';
import 'package:xfit_mobile/screens/home_page_screen.dart';
import 'package:xfit_mobile/screens/my_profile_screen.dart';
import 'package:xfit_mobile/screens/narudzba_screen.dart';
import 'package:xfit_mobile/screens/omiljeni_proizvodi_screen.dart';
import 'package:xfit_mobile/screens/product_list_screen.dart';
import 'package:xfit_mobile/screens/termin_screen.dart';

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
        title: widget.title_widget ?? Text(widget.title ?? ""),
        actions: [
          if (widget.showBackButton)
            TextButton.icon(
              onPressed: () {
                if (!ModalRoute.of(context)!.isFirst) {
                  Navigator.pop(context, 'reload2');
                }
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              label: const Text(
                "Back",
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 154, 222, 235), // Zelena pozadina za Drawer
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
                      builder: (context) => OrderScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Appointments'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TerminScreen(),
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

