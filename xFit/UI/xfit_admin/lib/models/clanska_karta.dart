
import 'package:json_annotation/json_annotation.dart';
import 'korisnik.dart';

part 'clanska_karta.g.dart';

@JsonSerializable()

class ClanskaKarta {
  int? clanskaKartaId;
  String? sadrzaj;
  int? korisnikId;
  Korisnik? korisnik;

  ClanskaKarta(this.clanskaKartaId, this.sadrzaj, this.korisnikId, this.korisnik);

  factory ClanskaKarta.fromJson(Map<String, dynamic> json) => _$ClanskaKartaFromJson(json);

  Map<String, dynamic> toJson() => _$ClanskaKartaToJson(this);
}