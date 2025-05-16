import 'dart:convert';



import 'package:xfit_mobilna/models/vrsta_proizvoda.dart';
import 'package:xfit_mobilna/providers/base_provider.dart';

class VrstaProizvodaProvider extends BaseProvider<VrsteProizvoda>{
    VrstaProizvodaProvider(): super("VrstaProizvodum");

   @override
  VrsteProizvoda fromJson(data) {
    // TODO: implement fromJson
    return VrsteProizvoda.fromJson(data);
  }
}