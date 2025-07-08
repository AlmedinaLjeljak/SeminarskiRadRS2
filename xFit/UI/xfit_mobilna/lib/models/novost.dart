import 'package:json_annotation/json_annotation.dart';

part 'novost.g.dart';

@JsonSerializable()
class Novost{
  int?novostId;
  String?naziv;
  String?sadzaj;
  DateTime?datumObjave;
  int?klijentId;

  Novost(this.novostId, this.naziv, this.sadzaj, this.datumObjave, this.klijentId);

  factory Novost.fromJson(Map<String, dynamic> json) => _$NovostFromJson(json);

  Map<String, dynamic> toJson() => _$NovostToJson(this);
}