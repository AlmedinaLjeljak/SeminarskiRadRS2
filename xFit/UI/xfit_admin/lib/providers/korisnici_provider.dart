import 'package:xfit_admin/models/korisnik.dart';
import 'package:xfit_admin/providers/base_provider.dart';

class KorisnisiProvider extends BaseProvider<Korisnik>{
  KorisnisiProvider():super("Korisnici");

  @override
  Korisnik fromJson(data){
    return Korisnik.fromJson(data);
  }
}