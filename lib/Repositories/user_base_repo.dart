import 'package:vet_project/models/vets.dart';

import 'package:shared_preferences/shared_preferences.dart';
abstract class UserRepository
{

  Future<Veterinaire> login(email,password) ;
  void dispose();
}