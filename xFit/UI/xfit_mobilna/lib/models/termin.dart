import 'package:json_annotation/json_annotation.dart';

part 'termin.g.dart';

@JsonSerializable()
class Termin{
	int? terminId; 
  DateTime? datum;
  int? korisnikIdUposlenik;
  int? korisnikIdKlijent;
  
  Termin(this.terminId, this.datum,this.korisnikIdUposlenik,this.korisnikIdKlijent);

  factory Termin.fromJson(Map<String, dynamic> json) => _$TerminFromJson(json);

  Map<String, dynamic> toJson() => _$TerminToJson(this);

}