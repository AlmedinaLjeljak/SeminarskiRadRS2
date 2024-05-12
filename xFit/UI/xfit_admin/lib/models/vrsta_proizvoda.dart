import 'package:json_annotation/json_annotation.dart';

part 'vrsta_proizvoda.g.dart';

@JsonSerializable()

class VrsteProizvoda {
  int? vrstaProizvodaId;
  String? naziv;

  VrsteProizvoda(this.vrstaProizvodaId, this.naziv);

  factory VrsteProizvoda.fromJson(Map<String, dynamic> json) => _$VrsteProizvodaFromJson(json);

  Map<String, dynamic> toJson() => _$VrsteProizvodaToJson(this);
}