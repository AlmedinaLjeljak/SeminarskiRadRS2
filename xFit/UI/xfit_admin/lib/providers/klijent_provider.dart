import 'package:xfit_admin/models/klijent.dart';
import 'package:xfit_admin/providers/base_provider.dart';

class KlijentProvider<T> extends BaseProvider<Klijent>{
  KlijentProvider():super("Klijent");

  @override
  Klijent fromJson(data){
    return Klijent.fromJson(data);
  }



}