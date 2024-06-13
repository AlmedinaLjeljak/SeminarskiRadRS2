import 'package:json_annotation/json_annotation.dart';

part 'klijent.g.dart';

@JsonSerializable()
class Klijent{
	int? klijentId; 
  String? ime;
  String? prezime;
  DateTime? datumRodjenja;
  int? korisnikId;
  
  Klijent(this.klijentId,this.ime,this.prezime,this.datumRodjenja,this.korisnikId);

  factory Klijent.fromJson(Map<String, dynamic> json) => _$KlijentFromJson(json);

  Map<String, dynamic> toJson() => _$KlijentToJson(this);

}
