/*import 'dart:convert';


import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xfit_admin/models/recommendResult.dart';
import 'package:xfit_admin/providers/base_provider.dart';

import '../models/product.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class RecommendResultProvider<T> extends BaseProvider<RecommendResult>{
  RecommendResultProvider(): super("RecommendResult");
 
 @override
  RecommendResult fromJson(data) {
    return RecommendResult.fromJson(data);
  }

   Future trainData() async {
  var url = "http://localhost:7138/RecommendResult/TrainModel";
  var uri = Uri.parse(url);
  var headers = createHeaders();

  try {
    var response = await http.post(uri, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('Response data: $data');
    } else {
      throw Exception("Failed to train model: ${response.statusCode}");
    }
  } catch (e) {
    print('Error during training model: $e');
    rethrow;
  }
}


  Future deleteData() async {
    var url = "http://localhost:7138/RecommendResult/ClearRecommendation";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.delete(uri, headers: headers);
    
    if(isValidResponse(response)) {
      
    } else {
      throw  Exception("Unknown error");
    }
  }
}
*/


import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xfit_admin/models/recommendResult.dart';
import 'package:xfit_admin/providers/base_provider.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;

class RecommendResultProvider<T> extends BaseProvider<RecommendResult> {
  RecommendResultProvider() : super("RecommendResult");

  @override
  RecommendResult fromJson(data) {
    return RecommendResult.fromJson(data);
  }

  Future trainData(BuildContext context) async {
    var url = "http://localhost:7138/RecommendResult/TrainModel";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    try {
      // Prikazujemo loader pre nego što počne proces
      showDialog(
        context: context,
        barrierDismissible: false, // Zatvori dijalog samo nakon završetka
        builder: (_) => Center(child: CircularProgressIndicator()),
      );

      var response = await http.post(uri, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Response data: $data');
        
        Navigator.of(context).pop(); // Zatvaramo loader dijalog
        // Prikazujemo toast poruku kada je uspešno završeno
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Model successfully trained!'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Navigator.of(context).pop(); // Zatvaramo loader dijalog
        throw Exception("Failed to train model: ${response.statusCode}");
      }
    } catch (e) {
      Navigator.of(context).pop(); // Zatvaramo loader dijalog
      print('Error during training model: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to train model. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
      rethrow;
    }
  }

  Future deleteData(BuildContext context) async {
    var url = "http://localhost:7138/RecommendResult/ClearRecommendation";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    
    try {
      // Prikazujemo loader pre nego što počne proces
      showDialog(
        context: context,
        barrierDismissible: false, // Zatvori dijalog samo nakon završetka
        builder: (_) => Center(child: CircularProgressIndicator()),
      );
      
      var response = await http.delete(uri, headers: headers);
      if (isValidResponse(response)) {
        Navigator.of(context).pop(); // Zatvaramo loader dijalog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Recommendations successfully deleted!'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Navigator.of(context).pop(); // Zatvaramo loader dijalog
        throw Exception("Failed to delete recommendations");
      }
    } catch (e) {
      Navigator.of(context).pop(); // Zatvaramo loader dijalog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete recommendations. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
