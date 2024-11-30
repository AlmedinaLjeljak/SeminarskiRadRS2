import 'package:xfit_admin/models/narudzba.dart';
import 'package:xfit_admin/models/stavkaNarudzbe.dart';
import 'package:xfit_admin/providers/base_provider.dart';

class OrdersProvider<T> extends BaseProvider<Narudzba>{
  OrdersProvider():super("Narudzba");

  @override
  Narudzba fromJson(data){
    return Narudzba.fromJson(data);
  }



}