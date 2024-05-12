// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Novost _$NovostFromJson(Map<String, dynamic> json) => Novost(
      (json['novostId'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['sadrzaj'] as String?,
      json['datumObjave'] == null
          ? null
          : DateTime.parse(json['datumObjave'] as String),
      (json['klijentId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NovostToJson(Novost instance) => <String, dynamic>{
      'novostId': instance.novostId,
      'naziv': instance.naziv,
      'sadrzaj': instance.sadrzaj,
      'datumObjave': instance.datumObjave?.toIso8601String(),
      'klijentId': instance.klijentId,
    };
