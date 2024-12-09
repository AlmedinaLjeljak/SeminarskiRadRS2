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
  Widget? child;
  String? title;
  Widget? title_widget; 
  bool showBackButton;
  MasterScreenWidget({this.child, this.title, this.title_widget, this.showBackButton = true, Key? key}) : super(key:key);

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
          TextButton.icon(
              onPressed: (() {
                if (!ModalRoute.of(context)!.isFirst) {
                  Navigator.pop(context,
                      'reload2');
                }
              }),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              label: Text(
                "Back",
                style: const TextStyle(color: Colors.white),
              )),
        ], 
      ),
      drawer: Drawer(
        child: ListView(
          children: [
             ListTile(
              title: Text('My profile'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Home page'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePageScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Products'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  ProductListScreen(),
                  ),
                );
              },
            ),
              ListTile(
              title: Text('Orders'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  OrderScreen(),
                  ),
                );
              },
            ),
              ListTile(
              title: Text('Appointments'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  TerminScreen(),
                  ),
                );
              },
            ),
              ListTile(
              title: Text('Cart'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  CartScreen(),
                  ),
                );
              },
            ),
             ListTile(
              title: Text('Favorites'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  FavoritesScreen(),
                  ),
                );
              },
            ),
             ListTile(
        title: Text('Log Out'),
        onTap: () {
          final korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
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
      body: widget.child,
    );
  }
}