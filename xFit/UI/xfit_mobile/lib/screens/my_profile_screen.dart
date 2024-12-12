import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobile/models/korisnik.dart';
import 'package:xfit_mobile/providers/korisnik_providder.dart';
import 'dart:convert';

import 'package:xfit_mobile/utils/util.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnisiProvider _korisniciProvider;
  late Future<Korisnik> _korisnikFuture;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _korisniciProvider = Provider.of<KorisnisiProvider>(context, listen: false);
    _loadKorisnikData();
  }

  Future<void> _loadKorisnikData() async {
    final korisnikId = await _getUserId();
    _korisnikFuture = _korisniciProvider.getById(korisnikId);
    setState(() {
      _isLoading = false;
    });
  }

  Future<int> _getUserId() async {
    final korisnici = await _korisniciProvider.get(filter: {
      'korisnickoIme': Authorization.username,
    });

    return korisnici.result.first.korisnikId!;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return FutureBuilder<Korisnik>(
        future: _korisnikFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error loading data');
          } else {
            final korisnikData = snapshot.data;

            return Scaffold(
              appBar: AppBar(title: Text("My Profile")),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/pozadina.jpg'),
                    fit: BoxFit.cover, // Pozadina će se prilagoditi veličini ekrana
                  ),
                ),
                child: FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Korisnička ikona na vrhu
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.account_circle,
                            size: 50,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Naslov "Podaci o korisniku"
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Podaci o korisniku",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        FormBuilderTextField(
                          name: 'ime',
                          initialValue: korisnikData?.ime ?? '',
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'First name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        FormBuilderTextField(
                          name: 'prezime',
                          initialValue: korisnikData?.prezime ?? '',
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Last name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        FormBuilderTextField(
                          name: 'korisnickoIme',
                          initialValue: korisnikData?.korisnickoIme ?? '',
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState != null) {
                              if (_formKey.currentState!.saveAndValidate()) {
                                var request =
                                    Map<String, dynamic>.from(_formKey.currentState!.value);
                                try {
                                  await _korisniciProvider.update(
                                      korisnikData!.korisnikId!, request);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text("Profile successfully updated!"),
                                    ),
                                  );
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text(e.toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          child: Text('Save'),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    }
  }
}
