// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omiljeni_proizvod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmiljeniProizvod _$OmiljeniProizvodFromJson(Map<String, dynamic> json) =>
    OmiljeniProizvod(
      (json['omiljeniProizvodId'] as num?)?.toInt(),
      json['datumDodavanja'] == null
          ? null
          : DateTime.parse(json['datumDodavanja'] as String),
      (json['proizvodId'] as num?)?.toInt(),
      (json['klijentId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OmiljeniProizvodToJson(OmiljeniProizvod instance) =>
    <String, dynamic>{
      'omiljeniProizvodId': instance.omiljeniProizvodId,
      'datumDodavanja': instance.datumDodavanja?.toIso8601String(),
      'proizvodId': instance.proizvodId,
      'klijentId': instance.klijentId,
    };
