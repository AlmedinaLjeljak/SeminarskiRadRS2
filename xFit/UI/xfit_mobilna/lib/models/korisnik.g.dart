// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
  (json['korisnikId'] as num?)?.toInt(),
  json['ime'] as String?,
  json['prezime'] as String?,
  json['datumRodjenja'] == null
      ? null
      : DateTime.parse(json['datumRodjenja'] as String),
  json['slika'] as String?,
  json['email'] as String?,
  json['telefon'] as String?,
  json['adresa'] as String?,
  json['korisnickoIme'] as String?,
);

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
  'korisnikId': instance.korisnikId,
  'ime': instance.ime,
  'prezime': instance.prezime,
  'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
  'slika': instance.slika,
  'email': instance.email,
  'telefon': instance.telefon,
  'adresa': instance.adresa,
  'slika': instance.slika,
  'korisnickoIme': instance.korisnickoIme,
};
