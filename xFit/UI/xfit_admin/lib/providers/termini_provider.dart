import 'package:xfit_admin/models/termin.dart';
import 'package:xfit_admin/providers/base_provider.dart';

class TerminiProvider<T> extends BaseProvider<Termin>{
  TerminiProvider():super("Termin");

  @override
  Termin fromJson(data){
    return Termin.fromJson(data);
  }
}