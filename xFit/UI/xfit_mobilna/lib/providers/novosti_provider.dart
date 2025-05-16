import 'package:xfit_mobilna/models/novost.dart';
import 'package:xfit_mobilna/providers/base_provider.dart';

class NovostiProvider<T> extends BaseProvider<Novost>{
  NovostiProvider():super("Novost");

  @override
  Novost fromJson(data){
    return Novost.fromJson(data);
  }
}