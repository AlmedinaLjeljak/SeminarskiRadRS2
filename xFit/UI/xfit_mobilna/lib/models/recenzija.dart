import 'package:json_annotation/json_annotation.dart';

part 'recenzija.g.dart';

@JsonSerializable()
class Recenzija {
  int? recenzijaId;
  String? sadrzaj;
  DateTime? datum;
  int? proizvodId;
  int? klijentId;

  Recenzija(this.recenzijaId, this.sadrzaj, this.datum, this.proizvodId, this.klijentId);

  factory Recenzija.fromJson(Map<String, dynamic> json) => _$RecenzijaFromJson(json);

  Map<String, dynamic> toJson() => _$RecenzijaToJson(this);
}
