import 'package:json_annotation/json_annotation.dart';

part 'termin.g.dart';

@JsonSerializable()
class Termin{
	int? terminId; 
  DateTime? datumVrijeme;
  
  Termin(this.terminId, this.datumVrijeme);

  factory Termin.fromJson(Map<String, dynamic> json) => _$TerminFromJson(json);

  Map<String, dynamic> toJson() => _$TerminToJson(this);

}