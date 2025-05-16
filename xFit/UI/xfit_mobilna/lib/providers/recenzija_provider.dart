import 'package:xfit_mobilna/models/recenzija.dart';
import 'package:xfit_mobilna/providers/base_provider.dart';

class RecenzijaProvider extends BaseProvider<Recenzija> {
  RecenzijaProvider() : super("Recenzija");

  @override
  Recenzija fromJson(data) {
    return Recenzija.fromJson(data);
  }
}
