import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:vet_project/models/clinique.dart';
import 'package:vet_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:vet_project/models/vets.dart';
import 'package:vet_project/views/calendar.dart';
import 'package:vet_project/views/home_page.dart';
import 'package:vet_project/views/login_page.dart';


// void main() => runApp(MyApp());
// initializeDateFormatting().then((_) => runApp(MyApp()));

void main()
{
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then((_)=>
  initializeDateFormatting().then((_) => runApp(MaterialApp(
    initialRoute: '/main',
    routes: {
      '/login' : (context)=>LoginPage(),
      '/home' : (context)=>CalendarWidget(),
      '/main' : (context)=>HomePage()

    },
   // home: CalendarWidget(),
    debugShowCheckedModeBanner: false,
  ))));
}


/// This Widget is the main application widget.
class MyApp extends StatefulWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      home: CalendarWidget(),
    );
  }
}



