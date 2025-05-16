// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vrsta_proizvoda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VrsteProizvoda _$VrsteProizvodaFromJson(Map<String, dynamic> json) =>
    VrsteProizvoda(
      (json['vrstaProizvodaId'] as num?)?.toInt(),
      json['naziv'] as String?,
    );

Map<String, dynamic> _$VrsteProizvodaToJson(VrsteProizvoda instance) =>
    <String, dynamic>{
      'vrstaProizvodaId': instance.vrstaProizvodaId,
      'naziv': instance.naziv,
    };
