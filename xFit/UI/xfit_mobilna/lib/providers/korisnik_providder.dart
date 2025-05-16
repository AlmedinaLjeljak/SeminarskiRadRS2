import 'package:xfit_mobilna/models/korisnik.dart';
import 'package:xfit_mobilna/providers/base_provider.dart';
import 'package:xfit_mobilna/utils/util.dart';

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