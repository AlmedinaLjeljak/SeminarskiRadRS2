import 'package:xfit_mobile/models/korisnik.dart';
import 'package:xfit_mobile/providers/base_provider.dart';
import 'package:xfit_mobile/utils/util.dart';

class KorisnisiProvider extends BaseProvider<Korisnik>{
  KorisnisiProvider():super("Korisnici");

  @override
  Korisnik fromJson(data){
    return Korisnik.fromJson(data);
  }
    void logout() {
    Authorization.username = null;
    Authorization.password = null;
  }
}