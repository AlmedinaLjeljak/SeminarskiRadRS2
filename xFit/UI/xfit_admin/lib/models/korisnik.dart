import 'package:json_annotation/json_annotation.dart';

    part 'korisnik.g.dart';

    @JsonSerializable()
    class Korisnik{
      int?korisnikId;
      String?ime;
      String?prezime;
      String?korisnickoIme;
      DateTime? datumRodjenja;

       Korisnik(this.korisnikId, this.ime, this.prezime, this.korisnickoIme, this.datumRodjenja, this.tipKorisnika);

      factory Korisnik.fromJson(Map<String, dynamic> json) => _$KorisnikFromJson(json);

      Map<String, dynamic> toJson() => _$KorisnikToJson(this);

    }