// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnikInsertRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikInsertRequest _$KorisnikInsertRequestFromJson(
        Map<String, dynamic> json) =>
    KorisnikInsertRequest(
      json['ime'] as String?,
      json['prezime'] as String?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['korisnickoIme'] as String?,
      json['password'] as String?,
      json['passwordPotvrda'] as String?,
      (json['gradId'] as num?)?.toInt(),
      (json['spolId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KorisnikInsertRequestToJson(
        KorisnikInsertRequest instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'korisnickoIme': instance.korisnickoIme,
      'password': instance.password,
      'passwordPotvrda': instance.passwordPotvrda,
      'gradId': instance.gradId,
      'spolId': instance.spolId,
    };
