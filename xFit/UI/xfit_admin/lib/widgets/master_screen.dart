import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xfit_admin/screens/product_detail_screen.dart';

/*class MasterScreenWidget extends StatefulWidget{
  Widget? child;
  MasterScreenWidget({this.child,Key? key}):super(key: key);

  @override
  State<MasterScreenWidget> createState()=> _MasterScreenWidgetState();

}

class _MasterScreenWidgetState extends State<MasterScreenWidget>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Test page"),
      ),
      body: widget.child!,
    );
  }
}*/


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Master Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MasterWidget(),
    );
  }
}

class MasterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izbornik'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Proizvod'),
            onTap: () {
              // Logika za navigaciju na ekran Proizvoda
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProizvodScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Rezervacija'),
            onTap: () {
              // Logika za navigaciju na ekran Rezervacije
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RezervacijaScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Detalji'),
            onTap: () {
              // Logika za navigaciju na ekran Detalja
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetaljiScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Uposlenik'),
            onTap: () {
              // Logika za navigaciju na ekran Uposlenika
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UposlenikScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProizvodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proizvod'),
      ),
      body: Center(
        child: Text('Ekran Proizvoda'),
      ),
    );
  }
}

class RezervacijaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervacija'),
      ),
      body: Center(
        child: Text('Ekran Rezervacije'),
      ),
    );
  }
}

class DetaljiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalji'),
      ),
      body: Center(
        child: Text('Ekran Detalja'),
      ),
    );
  }
}

class UposlenikScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uposlenik'),
      ),
      body: Center(
        child: Text('Ekran Uposlenika'),
      ),
    );
  }
}



