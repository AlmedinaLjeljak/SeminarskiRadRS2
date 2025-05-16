import 'package:xfit_mobilna/models/narudzba.dart';
import 'package:xfit_mobilna/providers/base_provider.dart';

class OrdersProvider<T> extends BaseProvider<Narudzba>{
  OrdersProvider():super("Narudzba");

  @override
  Narudzba fromJson(data){
    return Narudzba.fromJson(data);
  }



}