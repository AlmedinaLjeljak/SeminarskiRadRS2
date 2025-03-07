import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xfit_mobile/models/omiljeni_proizvod.dart';
import 'package:xfit_mobile/providers/base_provider.dart';

class OmiljeniProizvodProvider extends BaseProvider<OmiljeniProizvod> { 

   String? _mainBaseUrl;
   String _endpoint = "OmiljeniProizvod";

  OmiljeniProizvodProvider() : super("OmiljeniProizvod"){
    _mainBaseUrl = const String.fromEnvironment("mainBaseUrl", defaultValue: "http://10.0.2.2:7138/"); 
  }


  Future<bool> exists(int productId) async {
    final favorites = await get(filter: {"proizvodId": productId});
    return favorites.count > 0;
  }

   @override
  OmiljeniProizvod fromJson(data) {
    return OmiljeniProizvod.fromJson(data);
  }

    Future<dynamic> sendRabbit(dynamic object) async{
     var url = "$_mainBaseUrl$_endpoint";
     
    
    var uri = Uri.parse(url);
    var jsonRequest = jsonEncode(object);
    var headers = createHeaders();


    var response = await  http.post(uri, headers: headers, body:jsonRequest );
    
    if(isValidResponse(response)) {
      var data = jsonDecode(response.body);
      
      return data;
    } else {
      throw  Exception("Unknown error");
    }
  }
}
