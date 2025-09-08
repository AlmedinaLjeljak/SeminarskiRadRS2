import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xfit_mobilna/models/korisnik.dart';
import 'package:xfit_mobilna/providers/korisnik_providder.dart';
import 'package:xfit_mobilna/utils/util.dart';
import 'package:xfit_mobilna/widgets/master_screen.dart';

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
    final korisnikId = await _getKlijentId();
    _korisnikFuture = _korisniciProvider.getById(korisnikId);

    await _korisnikFuture;

    setState(() {
      _isLoading = false;
    });
  }

  Future<int> _getKlijentId() async {
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
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return FutureBuilder<Korisnik>(
        future: _korisnikFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No user data found"));
          } else {
            final korisnikData = snapshot.data!;

            return MasterScreenWidget(
              title_widget: const Text("My Profile"),
              child: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      // Profile image
                      GestureDetector(
                        onTap: () async {
                          final pickedImage = await ImagePicker().pickImage(
                              source: ImageSource.gallery);
                          if (pickedImage == null) return;

                          final image = File(pickedImage.path);
                          final imageBytes = await image.readAsBytes();
                          final base64String = base64Encode(imageBytes);

                          setState(() {
                            korisnikData.slika = base64String;
                          });
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: (korisnikData.slika != null &&
                                    korisnikData.slika!.isNotEmpty)
                                ? Image.memory(
                                    base64Decode(korisnikData.slika!),
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/no_image.jpg",
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // User fields
                      FormBuilderTextField(
                        name: 'ime',
                        initialValue: korisnikData.ime ?? '',
                        enabled: true,
                        decoration: const InputDecoration(
                          labelText: 'First name',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16),

                      FormBuilderTextField(
                        name: 'prezime',
                        initialValue: korisnikData.prezime ?? '',
                        enabled: true,
                        decoration: const InputDecoration(
                          labelText: 'Last name',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16),

                      FormBuilderTextField(
                        name: 'korisnickoIme',
                        initialValue: korisnikData.korisnickoIme ?? '',
                        enabled: true,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                      ),
                      const SizedBox(height: 16),

                      FormBuilderTextField(
                        name: 'email',
                        initialValue: korisnikData.email ?? '',
                        enabled: true,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 16),

                      FormBuilderTextField(
                        name: 'telefon',
                        initialValue: korisnikData.telefon ?? '',
                        enabled: true,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 16),

                      FormBuilderTextField(
                        name: 'adresa',
                        initialValue: korisnikData.adresa ?? '',
                        enabled: true,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          prefixIcon: Icon(Icons.location_on),
                        ),
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.saveAndValidate()) {
                            var request = Map<String, dynamic>.from(
                                _formKey.currentState!.value);

                            // Validation
                            if (request['ime'].isEmpty ||
                                request['prezime'].isEmpty ||
                                request['email'].isEmpty ||
                                request['telefon'].isEmpty ||
                                request['adresa'].isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                  title: const Text("Warning"),
                                  content: const Text(
                                      "All fields must be filled."),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            if (!RegExp(r"^(?:\+?\d{10}|\d{9})$")
                                .hasMatch(request['telefon'])) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                  title: const Text("Warning"),
                                  content: const Text(
                                      "Invalid phone number format."),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                                .hasMatch(request['email'])) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                  title: const Text("Warning"),
                                  content: const Text(
                                      "Invalid email format."),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            if (korisnikData.slika != null) {
                              request['slika'] = korisnikData.slika;
                            }

                            // Update user
                            try {
                              final updatedUser = await _korisniciProvider.update(
                                  korisnikData.korisnikId!, request);

                              // Update Authorization if username changed
                              if (updatedUser.korisnickoIme !=
                                  Authorization.username) {
                                Authorization.username =
                                    updatedUser.korisnickoIme;
                              }

                              // Refresh UI with updated data
                              setState(() {
                                korisnikData.ime = updatedUser.ime;
                                korisnikData.prezime = updatedUser.prezime;
                                korisnikData.korisnickoIme =
                                    updatedUser.korisnickoIme;
                                korisnikData.email = updatedUser.email;
                                korisnikData.telefon = updatedUser.telefon;
                                korisnikData.adresa = updatedUser.adresa;
                                korisnikData.slika = updatedUser.slika;
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.green,
                                duration: Duration(milliseconds: 1000),
                                content: Text(
                                    "'My profile' successfully updated!"),
                              ));
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                  title: const Text("Error"),
                                  content: Text(e.toString()),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text("OK")),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Save'),
                      ),
                      const SizedBox(height: 20),
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
