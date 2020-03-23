// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String vNom;
  String vPrenom;
  String vAddress;
  int vNumero;
  String vEmail;
  String vSpecialite;
  String vMotDePasse;
  String vPhoto;
  int cliniqueId;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    this.id,
    this.vNom,
    this.vPrenom,
    this.vAddress,
    this.vNumero,
    this.vEmail,
    this.vSpecialite,
    this.vMotDePasse,
    this.vPhoto,
    this.cliniqueId,
    this.createdAt,
    this.updatedAt,
  });
  static fillUser(List<User> ok) {
    ok.add(User(vNom: "amir"));
    ok.add(User(vNom: "sorour"));

    ok.add(User(vNom: "hedia"));
    ok.add(User(vNom: "mourad"));
    ok.add(User(vNom: "abdelhamid"));
    return ok;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        vNom: json["vNom"],
        vPrenom: json["vPrenom"],
        vAddress: json["vAddress"],
        vNumero: json["vNumero"],
        vEmail: json["vEmail"],
        vSpecialite: json["vSpecialite"],
        vMotDePasse: json["vMotDePasse"],
        vPhoto: json["vPhoto"],
        cliniqueId: json["CliniqueId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vNom": vNom,
        "vPrenom": vPrenom,
        "vAddress": vAddress,
        "vNumero": vNumero,
        "vEmail": vEmail,
        "vSpecialite": vSpecialite,
        "vMotDePasse": vMotDePasse,
        "vPhoto": vPhoto,
        "CliniqueId": cliniqueId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
