// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transakcija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transakcija _$TransakcijaFromJson(Map<String, dynamic> json) => Transakcija(
      transakcijaId: (json['transakcijaId'] as num?)?.toInt(),
      narudzbaId: (json['narudzbaId'] as num?)?.toInt(),
      iznos: (json['iznos'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TransakcijaToJson(Transakcija instance) =>
    <String, dynamic>{
      'transakcijaId': instance.transakcijaId,
      'narudzbaId': instance.narudzbaId,
      'iznos': instance.iznos,
    };
