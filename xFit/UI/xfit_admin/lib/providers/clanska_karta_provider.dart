

import 'package:xfit_admin/models/clanska_karta.dart';
import 'package:xfit_admin/providers/base_provider.dart';

class ClanskaKartaProvider<T> extends BaseProvider<ClanskaKarta>{
  ClanskaKartaProvider(): super("ClanskaKarta"); 

  @override
  ClanskaKarta fromJson(data) {
    return ClanskaKarta.fromJson(data);
  }

}