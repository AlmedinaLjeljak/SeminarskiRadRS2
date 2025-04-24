// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clanska_karta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClanskaKarta _$ClanskaKartaFromJson(Map<String, dynamic> json) => ClanskaKarta(
      (json['clanskaKartaId'] as num?)?.toInt(),
      json['sadrzaj'] as String?,
      (json['korisnikId'] as num?)?.toInt(),
      json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClanskaKartaToJson(ClanskaKarta instance) =>
    <String, dynamic>{
      'clanskaKartaId': instance.clanskaKartaId,
      'sadrzaj': instance.sadrzaj,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
    };
