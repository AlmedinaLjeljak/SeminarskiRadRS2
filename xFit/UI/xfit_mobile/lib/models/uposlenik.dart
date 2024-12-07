import 'package:json_annotation/json_annotation.dart';

part 'uposlenik.g.dart';

@JsonSerializable()
class Uposlenik{
	int? uposlenikId;
  String? ime; 
  String? prezime;
  DateTime? datumRodjenja;
  int?korisnikId;
  
  Uposlenik(this.uposlenikId,this.ime,this.prezime,this.datumRodjenja,this.korisnikId);

  factory Uposlenik.fromJson(Map<String, dynamic> json) => _$UposlenikFromJson(json);

  Map<String, dynamic> toJson() => _$UposlenikToJson(this);

}
