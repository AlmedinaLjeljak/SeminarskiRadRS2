import 'package:xfit_mobilna/models/transakcija.dart';
import 'package:xfit_mobilna/models/transakcija.dart';
import 'package:xfit_mobilna/providers/base_provider.dart';

class TransakcijaProvider<T> extends BaseProvider<Transakcija>{
  TransakcijaProvider():super("Transakcija");

  @override
  Transakcija fromJson(data){
    return Transakcija.fromJson(data);
  }
}