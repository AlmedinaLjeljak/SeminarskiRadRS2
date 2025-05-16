import 'package:flutter/material.dart';
import 'package:xfit_mobilna/models/product.dart';

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/recenzija.dart';
import '../models/search_result.dart';
import '../providers/recenzija_provider.dart';
import '../utils/util.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  ProductDetailsScreen(this.product);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late RecenzijaProvider _recenzijaProvider;
  TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recenzijaProvider = RecenzijaProvider();
  }

  void postReview() async {
    

    await _recenzijaProvider.insert({
      "sadrzaj": _reviewController.text,
      "datum": DateTime.now().toIso8601String(),
      "korisnikId": 1, 
      "proizvodId": widget.product.proizvodId,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Review posted"),
      backgroundColor: Colors.green,),
    );
    setState(() {
      _reviewController.clear();
    });
  }

  Future<List<Recenzija>> fetchRecenzije(int proizvodId) async{
    final recenzijeResult = await _recenzijaProvider.get(filter: {
      "proizvodId" : proizvodId
    });

    return recenzijeResult.result.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.naziv ?? "Product Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                child: widget.product.slika != ""
                    ? imageFromBase64String(widget.product.slika!)
                    : Text("No Image"),
              ),
              SizedBox(height: 16),
              Text(
                widget.product.naziv ?? "",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Cijena: ${formatNumber(widget.product.cijena) + " KM"}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(height: 20,),
              Text("Recenzije:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              FutureBuilder<SearchResult<Recenzija>>(
                future: _recenzijaProvider.get(filter: {"proizvodId": widget.product.proizvodId}),
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
                  return Text("Nema recenzija za ovaj proizvod.");
                } else {
                  final recenzijeList = snapshot.data!.result;
                return Column(
                  children: recenzijeList.map((recenzija) {
                    return Card( 
                      elevation: 3, 
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: ListTile(
                      title: Text(recenzija.sadrzaj!),
                      ),
                    );
                  }).toList(),
                );
              }},),

              SizedBox(height: 30),
              Container(
                width: double.infinity, 
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _reviewController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Write a review...",
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: postReview,
                      child: Text("Post"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
