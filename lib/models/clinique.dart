// To parse this JSON data, do
//
//     final clinique = cliniqueFromJson(jsonString);

import 'dart:convert';

List<Clinique> cliniqueFromJson(String str) => List<Clinique>.from(json.decode(str).map((x) => Clinique.fromJson(x)));

String cliniqueToJson(List<Clinique> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Clinique {
    int id;
    int telNo;
    String address;
    String cliniqueNom;
    String heureOuvertue;
    String cliniqueEmail;
    DateTime createdAt;
    DateTime updatedAt;

    Clinique({
        this.id,
        this.telNo,
        this.address,
        this.cliniqueNom,
        this.heureOuvertue,
        this.cliniqueEmail,
        this.createdAt,
        this.updatedAt,
    });

    factory Clinique.fromJson(Map<String, dynamic> json) => Clinique(
        id: json["id"],
        telNo: json["telNo"] == null ? null : json["telNo"],
        address: json["address"] == null ? null : json["address"],
        cliniqueNom: json["cliniqueNom"] == null ? null : json["cliniqueNom"],
        heureOuvertue: json["HeureOuvertue"] == null ? null : json["HeureOuvertue"],
        cliniqueEmail: json["CliniqueEmail"] == null ? null : json["CliniqueEmail"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "telNo": telNo == null ? null : telNo,
        "address": address == null ? null : address,
        "cliniqueNom": cliniqueNom == null ? null : cliniqueNom,
        "HeureOuvertue": heureOuvertue == null ? null : heureOuvertue,
        "CliniqueEmail": cliniqueEmail == null ? null : cliniqueEmail,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
