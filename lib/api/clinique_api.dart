import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:vet_project/models/clinique.dart';
import 'package:http/http.dart' as http;
import 'package:vet_project/models/vets.dart';

class CliniquerProvider extends ChangeNotifier {
  List<Clinique> global_cliniques = new List<Clinique>();
  bool loading = false;
  List<Veterinaire> vetos = new List<Veterinaire>();

  Future<List<Veterinaire>> get_vetos(id_cl) async {
    setLoading(true);
    Map json_ = {'CliniqueId': '$id_cl'};
    // var headers = {"Content-Type": "application/json"};
    return http
        .post("http://192.168.1.50:3000/vets/ByClinique",
            body: json_, )
        .then((response) {
      vetos = new List<Veterinaire>.from(json
          .decode(response.body)
          .map((veterinaire) => Veterinaire.fromJson(veterinaire)));
      return vetos;
    }).whenComplete(() {
      print("accessing when complete api");
      setLoading(false);
      setVetos(vetos);
    });
  }

  Future<List<Clinique>> get_clinique() async {
    setLoading(true);
    return http.get("http://192.168.1.50:3000/cliniques/all").then((response) {
      global_cliniques = new List<Clinique>.from(json
          .decode(response.body)
          .map((clinique) => Clinique.fromJson(clinique)));
      return global_cliniques;
    }).whenComplete(() {
      print("accessing when complete api");
      setLoading(false);
      setCliniques(global_cliniques);
      notifyListeners();
    });
  }

  Future<String> deleteClinique(id) async {
    setLoading(true);
    return http.post("http://192.168.1.50:3000/cliniques/all").then((response) {
      global_cliniques = new List<Clinique>.from(json
          .decode(response.body)
          .map((clinique) => Clinique.fromJson(clinique)));
      return "global_cliniques";
    }).whenComplete(() {
      print("accessing when complete api");
      setLoading(false);
      setCliniques(global_cliniques);
    });
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool getLoading() {
    return loading;
  }

  void setCliniques(List<Clinique> value) {
    // print(value[0].address);
    // global_cliniques[i]
    global_cliniques = value;
    notifyListeners();
  }

  void setVetos(List<Veterinaire> value) {
    // print(value[0].vNom);
    // global_cliniques[i]
    vetos = value;
    notifyListeners();
  }

  getCliniques() {
    return global_cliniques;
  }
   getVetos() {
    return vetos;
  }
}
