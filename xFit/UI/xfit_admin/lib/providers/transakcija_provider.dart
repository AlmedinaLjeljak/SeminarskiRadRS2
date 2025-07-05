import 'package:xfit_admin/models/transakcija.dart';
import 'package:xfit_admin/providers/base_provider.dart';

class TransakcijaProvider extends BaseProvider<Transakcija> {
  TransakcijaProvider() : super("Transakcija");

  @override
  Transakcija fromJson(data) {
    return Transakcija.fromJson(data);
  }
}
