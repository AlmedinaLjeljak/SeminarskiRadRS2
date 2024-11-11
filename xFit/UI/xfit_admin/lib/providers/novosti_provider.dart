import 'package:xfit_admin/models/novost.dart';
import 'package:xfit_admin/providers/base_provider.dart';

class NovostiProvider<T> extends BaseProvider<Novost>{
  NovostiProvider():super("Novost");

  @override
  Novost fromJson(data){
    return Novost.fromJson(data);
  }
}