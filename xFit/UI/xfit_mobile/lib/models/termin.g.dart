// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termin _$TerminFromJson(Map<String, dynamic> json) => Termin(
      (json['terminId'] as num?)?.toInt(),
      json['datumVrijeme'] == null
          ? null
          : DateTime.parse(json['datumVrijeme'] as String),
    );

Map<String, dynamic> _$TerminToJson(Termin instance) => <String, dynamic>{
      'terminId': instance.terminId,
      'datumVrijeme': instance.datumVrijeme?.toIso8601String(),
    };