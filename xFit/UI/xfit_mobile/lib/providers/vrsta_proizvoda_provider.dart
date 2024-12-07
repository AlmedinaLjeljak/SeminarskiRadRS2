import 'dart:convert';


import 'package:xfit_mobile/models/vrsta_proizvoda.dart';
import 'package:xfit_mobile/providers/base_provider.dart';

class VrstaProizvodaProvider extends BaseProvider<VrsteProizvoda>{
    VrstaProizvodaProvider(): super("VrstaProizvodum");

   @override
  VrsteProizvoda fromJson(data) {
    // TODO: implement fromJson
    return VrsteProizvoda.fromJson(data);
  }
}