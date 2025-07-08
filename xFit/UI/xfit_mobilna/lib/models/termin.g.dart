// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termin _$TerminFromJson(Map<String, dynamic> json) => Termin(
  (json['terminId'] as num?)?.toInt(),
  json['datum'] == null
      ? null
      : DateTime.parse(json['datum'] as String),
  (json['korisnikIdUposlenik'] as num?)?.toInt(),
  (json['korisnikIdKlijent'] as num?)?.toInt(),
);

Map<String, dynamic> _$TerminToJson(Termin instance) => <String, dynamic>{
  'terminId': instance.terminId,
  'datum': instance.datum?.toIso8601String(),
  'korisnikIdUposlenik': instance.korisnikIdUposlenik,
  'korisnikIdKlijent': instance.korisnikIdKlijent,
};
