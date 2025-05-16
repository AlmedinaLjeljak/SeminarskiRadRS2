// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uposlenik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uposlenik _$UposlenikFromJson(Map<String, dynamic> json) => Uposlenik(
  (json['uposlenikId'] as num?)?.toInt(),
  json['ime'] as String?,
  json['prezime'] as String?,
  json['datumRodjenja'] == null
      ? null
      : DateTime.parse(json['datumRodjenja'] as String),
  (json['korisnikId'] as num?)?.toInt(),
);

Map<String, dynamic> _$UposlenikToJson(Uposlenik instance) => <String, dynamic>{
  'uposlenikId': instance.uposlenikId,
  'ime': instance.ime,
  'prezime': instance.prezime,
  'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
  'korisnikId': instance.korisnikId,
};
