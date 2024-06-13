/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProizvodProvajder with ChangeNotifier{
  static String? _baseURL;
  String _endPoint="Proizvod";

  ProizvodProvajder(){
    _baseURL=const String.fromEnvironment("baseUrl",defaultValue: "https://localhost:7138/");
  }

  Future<dynamic> get() async {
    var url="$_baseURL$_endPoint";

    var uri=Uri.parse(url);
    var headers=createheaders();


    var response=await http.get(uri,headers: headers);
print("response: ${response.request},${response.statusCode},${response.body}");

    var data=jsonDecode(response.body);

    return data;

  } 

  Map<String,String> createheaders(){
    String Username="admin";
    String Password="test";

    String basicAUTH="Basic ${base64Encode(utf8.encode('$Username:$Password'))}";

var headers={
  "Content-Type":"application/json",
  "Authorization":basicAUTH
};

return headers;

  }
}*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProizvodProvajder with ChangeNotifier {
  static String? _baseURL;
  String _endPoint = "Proizvod";

  ProizvodProvajder() {
    _baseURL = const String.fromEnvironment("baseUrl", defaultValue: "https://localhost:7138/");
  }

  Future<dynamic> get() async {
    try {
      var url = "$_baseURL$_endPoint";
      var uri = Uri.parse(url);

      print("Sending GET request to $url");

      var response = await http.get(uri);

      print("Response received. Status code: ${response.statusCode}, Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
        throw Exception("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in get method: $e");
      rethrow;
    }
  }
}
