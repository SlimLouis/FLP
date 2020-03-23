import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vet_project/Repositories/user_repo_.dart';
import 'package:vet_project/models/vets.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  final userRepo = UserRepo();

  bool loading;

  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'What is your usename/email?',
                      labelText: 'Email/username *',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      print(value);
                    },
                    validator: (String value) {
                      return (emailValid(value)) ? null : "Email is not valid";
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'What is your password?',
                      labelText: 'password *',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return (value.length >= 6)
                          ? null
                          : "password must exceed 6 characters";
                    },
                  ),
                  (loading == true)
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                userRepo
                                    .login(emailController.text.trim(),
                                        passwordController.text.trim())
                                    .then((data) {
                                  if (data.id != null) {
                                    Navigator.pushNamed(context, '/home',
                                        arguments: data);
                                        return ;
                                  }
                                Flushbar(
                                    animationDuration: Duration(seconds: 3),
                                    message: "Login failed",
                                    title: "Incorrect Credentials",
                                    backgroundColor: Colors.red,
                                    icon: Icon(Icons.warning))..show(context);
                                  return ;
                                }).catchError((onError) {
                                  Flushbar(
                                    animationDuration: Duration(seconds: 3),
                                    message: "Login failed",
                                    title: "Incorrect Credentials",
                                    backgroundColor: Colors.red,
                                    icon: Icon(Icons.warning))..show(context);
                                  
                                });
                              });
                            }
                          },
                        )
                ],
              )),
        ),
      ),
    );
  }

  bool emailValid(email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
