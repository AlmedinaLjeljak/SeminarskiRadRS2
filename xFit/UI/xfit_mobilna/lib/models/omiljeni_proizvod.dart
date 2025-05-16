 import 'package:json_annotation/json_annotation.dart';

part 'omiljeni_proizvod.g.dart';

@JsonSerializable()
class OmiljeniProizvod{
	int? omiljeniProizvodId;
  DateTime? datumDodavanja;
	int? proizvodId;
	int? klijentId;

  OmiljeniProizvod(this.omiljeniProizvodId, this.datumDodavanja, this.proizvodId,this.klijentId);

  factory OmiljeniProizvod.fromJson(Map<String, dynamic> json) => _$OmiljeniProizvodFromJson(json);

  Map<String, dynamic> toJson() => _$OmiljeniProizvodToJson(this);

}