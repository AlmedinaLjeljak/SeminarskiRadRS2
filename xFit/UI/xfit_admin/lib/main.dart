
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/providers/clanska_karta_provider.dart';
import 'package:xfit_admin/providers/korisnici_provider.dart';
import 'package:xfit_admin/providers/narudzba_provider.dart';
import 'package:xfit_admin/providers/novosti_provider.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/providers/recommendResul_provider.dart';
import 'package:xfit_admin/providers/stavka_narudzbe_provider.dart';
import 'package:xfit_admin/providers/termini_provider.dart';
import 'package:xfit_admin/providers/vrsta_provider.dart';
import 'package:xfit_admin/screens/product_list_screen.dart';
import 'package:xfit_admin/utils/util.dart';


class OrderDetailState extends ChangeNotifier {
  Map<String, dynamic>? _orderDetails;

  Map<String, dynamic>? get orderDetails => _orderDetails;

  void updateOrderDetails(Map<String, dynamic> newOrderDetails) {
    _orderDetails = Map<String, dynamic>.from(newOrderDetails);
    notifyListeners();
  }
}

class ProductDetailState extends ChangeNotifier {
  Map<String, dynamic>? _productDetails;

  Map<String, dynamic>? get productDetails => _productDetails;

  void updateProductDetails(Map<String, dynamic> newProductDetails) {
    _productDetails = Map<String, dynamic>.from(newProductDetails);
    notifyListeners();
  }
}
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ChangeNotifierProvider(create: (_) => NovostiProvider()),
      ChangeNotifierProvider(create: (_) => VrstaProizvodaProvider()),
      ChangeNotifierProvider(create: (_) => ClanskaKartaProvider()),
      ChangeNotifierProvider(create: (_) => TerminiProvider()),
      ChangeNotifierProvider(create: (_) => KorisnisiProvider()),
      ChangeNotifierProvider(create: (_) => StavkaNarudzbeProvider()),
      ChangeNotifierProvider(create: (_) => ProductDetailState()),
      ChangeNotifierProvider(create: (_) => OrderDetailState()),
      ChangeNotifierProvider(create: (_) => RecommendResultProvider()),
    ],
    child: const MyMaterialApp(),
  ));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RS II Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Plava boja za AppBar i osnovne komponente
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = context.read<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color.fromARGB(255, 186, 231, 240), 
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset("assets/images/logo1.png", height: 100, width: 100),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.email),
                    ),
                    controller: _usernameController,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password),
                    ),
                    controller: _passwordController,
                    obscureText: true, 
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      var username = _usernameController.text;
                      var password = _passwordController.text;
                      _passwordController.text = username;
                      print("Login proceed $username $password");

                      Authorization.username = username;
                      Authorization.password = password;

                      try {
                        await _productProvider.get();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const ProductListScreen()),
                        );
                      } on Exception catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: Text("OK")),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
