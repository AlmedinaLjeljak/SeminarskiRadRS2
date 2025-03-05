import 'dart:convert';


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
