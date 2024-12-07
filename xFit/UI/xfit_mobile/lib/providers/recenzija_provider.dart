import 'package:xfit_mobile/models/recenzija.dart';
import 'package:xfit_mobile/providers/base_provider.dart';

class RecenzijaProvider<T> extends BaseProvider<Recenzija>{
  RecenzijaProvider():super("Recenzija");

  @override
  Recenzija fromJson(data){
    return Recenzija.fromJson(data);
  }
}