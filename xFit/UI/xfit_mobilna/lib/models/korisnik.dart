import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik {
  int? korisnikId;
  String? ime;
  String? prezime;
  DateTime? datumRodjenja;
  String? slika;
  String? email;
  String? telefon;
  String? adresa;
  String? korisnickoIme;


  Korisnik(this.korisnikId, this.ime, this.prezime, this.datumRodjenja,this.slika,this.email,this.telefon,this.adresa,this.korisnickoIme);

  factory Korisnik.fromJson(Map<String, dynamic> json) => _$KorisnikFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}