
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobile/models/grad.dart';
import 'package:xfit_mobile/providers/cart_provider.dart';
import 'package:xfit_mobile/providers/grad_provider.dart';
import 'package:xfit_mobile/providers/korisnik_providder.dart';
import 'package:xfit_mobile/providers/narudzba_provider.dart';
import 'package:xfit_mobile/providers/novosti_provider.dart';
import 'package:xfit_mobile/providers/omiljeni_proizvod_provider.dart';
import 'package:xfit_mobile/providers/omiljeni_proizvod_provider.dart'; 
import 'package:xfit_mobile/providers/product_provider.dart';
import 'package:xfit_mobile/providers/recenzija_provider.dart';
import 'package:xfit_mobile/providers/recommendResult_provider.dart';
import 'package:xfit_mobile/providers/termini_provider.dart';
import 'package:xfit_mobile/providers/transakcija_provider.dart';
import 'package:xfit_mobile/providers/vrsta_proizvoda_provider.dart';
import 'package:xfit_mobile/screens/product_list_screen.dart';
import 'package:xfit_mobile/utils/util.dart';
import 'package:xfit_mobile/widgets/master_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyMaterialApp());
}

class ProductDetailState extends ChangeNotifier {
  Map<String, dynamic>? _productDetails;

  Map<String, dynamic>? get productDetails => _productDetails;

  void updateProductDetails(Map<String, dynamic> newProductDetails) {
    _productDetails = Map<String, dynamic>.from(newProductDetails);
    notifyListeners();
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => NovostiProvider()),
        ChangeNotifierProvider(create: (_) => TerminiProvider()),
        ChangeNotifierProvider(create: (_) => KorisnisiProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OmiljeniProizvodProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailState()),
        ChangeNotifierProvider(create: (_) => VrstaProizvodaProvider()),
        ChangeNotifierProvider(create: (_) => RecenzijaProvider()),
        ChangeNotifierProvider(create: (_) => TransakcijaProvider()),
        ChangeNotifierProvider(create: (_) => GradProvider()),
        ChangeNotifierProvider(create: (_) => RecommendResultProvider()),
      ],
      child: MaterialApp(
        title: 'RS II Material app',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Welcome(),
      ),
    );
}
}

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('WELCOME TO X-FIT', style: TextStyle(fontFamily: 'YourCustomFont', fontWeight: FontWeight.bold, fontSize: 24, color: Color.fromARGB(255, 28, 202, 211),),),
              ),

              SizedBox(height: size.height * 0.02),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text("LOGIN"),
                  ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text("SIGN UP"),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = context.read<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxHeight: 800, maxWidth: 400),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset("assets/images/logo.png", height: 150, width: 300),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Username", prefixIcon: Icon(Icons.email)),
                    controller: _usernameController,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Password", prefixIcon: Icon(Icons.password)),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      var username = _usernameController.text;
                      var password = _passwordController.text;

                      print("login proceed $username $password");

                      Authorization.username = username;
                      Authorization.password = password;

                      try {
                        await _productProvider.get();

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductListScreen()));
                      } on Exception catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"))
                            ],
                          ),
                        );
                      }
                    },
                    child: Text("Login"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  late KorisnisiProvider _korisniciProvider;
  late GradProvider _gradoviProvider;
  List<Grad> _cities = [];
  int? _selectedCityId;

  @override
  void initState() {
    super.initState();
    _korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
    _gradoviProvider = Provider.of<GradProvider>(context, listen: false);
    _loadCities();
  }

  Future<void> _loadCities() async {
    try {
      var result = await _gradoviProvider.get();
      setState(() {
        _cities = result.result; 
      });
    } catch (e) {
      print("Error fetching cities: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxHeight: 600, maxWidth: 400),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Image.asset("assets/images/logo.png", height: 150, width: 300),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "First Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    controller: _firstnameController,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    controller: _lastnameController,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.account_circle),
                    ),
                    controller: _usernameController,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Select gender: 1-MALE, 2-FEMALE",
                      prefixIcon: Icon(Icons.transgender),
                    ),
                    controller: _genderController,
                  ),
                  SizedBox(height: 8),
               
                  DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      labelText: "Select City",
                      prefixIcon: Icon(Icons.location_city),
                    ),
                    value: _selectedCityId,
                    items: _cities
                        .map((city) => DropdownMenuItem<int>(
                              value: city.gradId,
                              child: Text(city.naziv ?? "Unknown City"),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCityId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a city';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    controller: _confirmPasswordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      if (_firstnameController.text.isEmpty ||
                          _lastnameController.text.isEmpty ||
                          _usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _confirmPasswordController.text.isEmpty ||
                          _selectedCityId == null ||
                          _genderController.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Error"),
                            content: Text("All fields are required!"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK")),
                            ],
                          ),
                        );
                      } else if (_genderController.text.toUpperCase() != '1' &&
                          _genderController.text.toUpperCase() != '2') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Error"),
                            content:
                                Text("Please enter '1' or '2' for gender."),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK")),
                            ],
                          ),
                        );
                      } else if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(
                                "Password needs to match the confirmation password."),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK")),
                            ],
                          ),
                        );
                      } else {
                        Map order = {
                          "ime": _firstnameController.text,
                          "prezime": _lastnameController.text,
                          "korisnickoIme": _usernameController.text,
                          "password": _passwordController.text,
                          "passwordPotvrda": _confirmPasswordController.text,
                          "gradId": _selectedCityId,
                          "spolId": _genderController.text,
                        };

                        var x = await _korisniciProvider.SignUp(order);
                        print(x);
                        if (x != null) {
                          Authorization.username = _usernameController.text;
                          Authorization.password = _passwordController.text;

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductListScreen(),
                          ));
                        }
                      }
                    },
                    child: Center(child: Text("Sign up")),
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
