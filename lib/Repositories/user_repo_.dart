import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vet_project/Repositories/user_base_repo.dart';
import 'package:vet_project/models/clinique.dart';
import 'package:vet_project/models/vets.dart';
import 'package:http/http.dart' as http;

class UserRepo extends UserRepository {
  static const baseurl = "http://192.168.1.5:3000/";
  static const route_ = "vets/";
  final http.Client httpClient;

  UserRepo({http.Client httpClient}) : httpClient = httpClient ?? http.Client();

//   POST http://localhost:3000/vets/Login HTTP/1.1
// Content-Type: application/json

// {
//     "email":"amirof@gmail.com",
//     "password":"4130261"
// }

  @override
  Future<Veterinaire> login(email, password) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var user = {'email': email, 'password': password};
    Clinique cl = new Clinique();
    Veterinaire vet = new Veterinaire();
    String token;
    String refreshToken;
    var body = json.encode(user);
    try {
      final response = await httpClient.post(baseurl + route_ + 'Login',
          body: body,
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        cl = Clinique.fromJson(json.decode(response.body)[0]['Clinique']);
        vet =
            Veterinaire.fromJson(json.decode(response.body)[0]['Veterinaire']);
         shared.setString('clinique', cl.toJson().toString());
        print("done");

      }
      return vet;
    } catch (e) {
      throw (e);
    }

    throw UnimplementedError();
  }

  @override
  void dispose() {
    httpClient.close();
  }
}
