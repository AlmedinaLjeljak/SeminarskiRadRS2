import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobile/models/korisnik.dart';
import 'package:xfit_mobile/providers/korisnik_providder.dart';
import 'package:xfit_mobile/utils/util.dart';
import 'package:xfit_mobile/widgets/master_screen.dart';

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
    final korisnikId = await getKlijentId();
    _korisnikFuture = _korisniciProvider.getById(korisnikId);

    await Future.delayed(Duration(milliseconds: 300));

    setState(() {
      _isLoading = false;
    });
  }

  Future<int> getKlijentId() async {
    final klijenti = await _korisniciProvider.get(filter: {
      'korisnikUlogas': 'klijent',
    });

    final klijent = klijenti.result.firstWhere(
        (korisnik) => korisnik.korisnickoIme == Authorization.username);

    return klijent.korisnikId!;
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

            return MasterScreenWidget(
              title_widget: Text("My Profile"),
              child: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                 
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100), 
                        child: Image.asset(
                          'assets/images/no_image.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
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
                              var request = Map<String, dynamic>.from(
                                  _formKey.currentState!.value);

                              if (request.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text("Warning"),
                                    content: Text(
                                        "Fields cannot be empty. Please fill in all fields."),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }

                              try {
                                await _korisniciProvider.update(
                                    korisnikData!.korisnikId!, request);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    duration: Duration(milliseconds: 1000),
                                    content: Text(
                                        "'My profile' successfully updated!"),
                                  ),
                                );
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text("Error"),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK")),
                                    ],
                                  ),
                                );
                              }
                            }
                          } else {
                            print("");
                          }
                        },
                        child: Text('Save'),
                      ),
                      SizedBox(height: 20),
                    ],
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
