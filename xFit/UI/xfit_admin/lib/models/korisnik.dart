import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik {
  int? korisnikId;
  String? ime;
  String? prezime;
  DateTime? datumRodjenja;
  String? korisnickoIme;


  Korisnik(this.korisnikId, this.ime, this.prezime, this.datumRodjenja,this.korisnickoIme);

  factory Korisnik.fromJson(Map<String, dynamic> json) => _$KorisnikFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
