import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void write_height() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print("this is the height $height and this is the width $width");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    write_height();
    return LoginContainer();
  }
}

class LoginContainer extends StatefulWidget {
  const LoginContainer({Key key}) : super(key: key);
  

  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {


  Future<String> _calculation = Future<String>.delayed(
  Duration(seconds: 2),
  () => 'Data Loaded',
);

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: FutureBuilder<String>(
      future: _calculation,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> l_s;
        if (snapshot.hasData) {
          l_s:
          [Icon(Icons.ac_unit), Text("Result ${snapshot.data}")];
        } else if (snapshot.hasError) {
          ls:
          [
            Text("error"),
          ];
        } else {
          ls:
          [
            SizedBox(
              child: CircularProgressIndicator(),
              height: 150,
              width: 150,
            ),
            Text("Waiting data")
          ];
        }

        return Center(
          child: Column(
            children: l_s,
          ),
        );
      },
    ));
  }
}

