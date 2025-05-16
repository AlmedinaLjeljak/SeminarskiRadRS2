import 'package:json_annotation/json_annotation.dart';

part 'korisnikInsertRequest.g.dart';

@JsonSerializable()
class KorisnikInsertRequest {
  String? ime;
  String? prezime;
  DateTime? datumRodjenja;
  String? korisnickoIme;
  String? password;
  String? passwordPotvrda;
  int? gradId;
  int? spolId;

  KorisnikInsertRequest(this.ime, this.prezime, this.datumRodjenja, this.korisnickoIme,this.password, this.passwordPotvrda, this.gradId,this.spolId);

  factory KorisnikInsertRequest.fromJson(Map<String, dynamic> json) => _$KorisnikInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnikInsertRequestToJson(this);
}
