
import 'package:xfit_mobile/models/omiljeni_proizvod.dart';
import 'package:xfit_mobile/providers/base_provider.dart';

class OmiljeniProizvodProvider extends BaseProvider<OmiljeniProizvod> {
  OmiljeniProizvodProvider() : super("OmiljeniProizvod");

  Future<bool> exists(int productId) async {
    final favorites = await get(filter: {"proizvodId": productId});
    return favorites.count > 0;
  }
  @override
  OmiljeniProizvod fromJson(data) {
    return OmiljeniProizvod.fromJson(data);
  }
}
