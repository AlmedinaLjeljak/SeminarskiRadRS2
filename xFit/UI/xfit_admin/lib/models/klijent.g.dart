// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'klijent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Klijent _$KlijentFromJson(Map<String, dynamic> json) => Klijent(
      (json['klijentId'] as num?)?.toInt(),
      json['ime'] as String?,
      json['prezime'] as String?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      (json['korisnikId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KlijentToJson(Klijent instance) => <String, dynamic>{
      'klijentId': instance.klijentId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'korisnikId': instance.korisnikId,
    };
