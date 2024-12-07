import 'package:xfit_mobile/models/novost.dart';
import 'package:xfit_mobile/providers/base_provider.dart';

class NovostiProvider<T> extends BaseProvider<Novost>{
  NovostiProvider():super("Novost");

  @override
  Novost fromJson(data){
    return Novost.fromJson(data);
  }
}