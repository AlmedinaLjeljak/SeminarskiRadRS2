import 'package:xfit_mobile/models/narudzba.dart';
import 'package:xfit_mobile/providers/base_provider.dart';

class OrdersProvider<T> extends BaseProvider<Narudzba>{
  OrdersProvider():super("Narudzba");

  @override
  Narudzba fromJson(data){
    return Narudzba.fromJson(data);
  }



}