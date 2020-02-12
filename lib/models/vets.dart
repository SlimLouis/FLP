// To parse this JSON data, do
//
//     final clinique = cliniqueFromJson(jsonString);

import 'dart:convert';

List<Veterinaire> veterinaireFromJson(String str) => List<Veterinaire>.from(
    json.decode(str).map((x) => Veterinaire.fromJson(x)));

class Veterinaire {
  int id;
  int vNumero;
  String vNom;
  String vPrenom;
  String vAddress;
  String vEmail;
  String vSpecialite;
  String vMotDePasse;
  String vPhoto;
  DateTime createdAt;
  DateTime updatedAt;

  Veterinaire({
    this.id,
    this.vNumero,
    this.vNom,
    this.vPrenom,
    this.vAddress,
    this.vEmail,
    this.vSpecialite,
    this.vMotDePasse,
    this.vPhoto,
    this.createdAt,
    this.updatedAt,
  });

  factory Veterinaire.fromJson(Map<String, dynamic> json) => Veterinaire(
        id: json["id"],
        vNumero: json["vNumero"] == null ? null : json["vNumero"],
        vNom: json["vNom"] == null ? null : json["vNom"],
        vPrenom: json["vPrenom"] == null ? null : json["vPrenom"],
        vAddress: json["vAddress"] == null ? null : json["vAddress"],
        vEmail: json["vEmail"] == null ? null : json["vEmail"],
        vSpecialite: json["vSpecialite"] == null ? null : json["vSpecialite"],
        vMotDePasse: json["vMotDePasse"] == null ? null : json["vMotDePasse"],
        vPhoto: json["vPhoto"] == null ? null : json["vPhoto"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "telNo": telNo == null ? null : telNo,
  //       "address": address == null ? null : address,
  //       "cliniqueNom": cliniqueNom == null ? null : cliniqueNom,
  //       "HeureOuvertue": heureOuvertue == null ? null : heureOuvertue,
  //       "CliniqueEmail": cliniqueEmail == null ? null : cliniqueEmail,
  //       "createdAt": createdAt.toIso8601String(),
  //       "updatedAt": updatedAt.toIso8601String(),
  //     };
}
