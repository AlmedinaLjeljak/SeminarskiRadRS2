
import 'package:xfit_mobile/models/omiljeni_proizvod.dart';
import 'package:xfit_mobile/providers/base_provider.dart';

class OmiljeniProizvodProvider extends BaseProvider<OmiljeniProizvod> {
  OmiljeniProizvodProvider() : super("OmiljeniProizvod");

  @override
  OmiljeniProizvod fromJson(data) {
    return OmiljeniProizvod.fromJson(data);
  }
}
