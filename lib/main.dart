import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vet_project/models/clinique.dart';
import 'package:vet_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:vet_project/models/vets.dart';

import 'api/clinique_api.dart';

// void main() => runApp(MyApp());
void main() => runApp(ChangeNotifierProvider<CliniquerProvider>(
      create: (context) => CliniquerProvider(),
      child: MaterialApp(
        home: MyStatefulWidget(),
        debugShowCheckedModeBanner: false,
      ),
    ));

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
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  GlobalKey appbar;

  ///params declared for this page
  List<Clinique> global_cliniques = new List<Clinique>();
  List<Veterinaire> vetos = new List<Veterinaire>();
  Map<int, List<Veterinaire>> vetos_by_cl = new Map<int, List<Veterinaire>>();
  Map<int, String> dropDown_uniques = new Map<int, String>();

  String currenxt_id_cl2 = null;
  String current_vet = null;

  List<DropdownMenuItem<String>> menuItems =
      new List<DropdownMenuItem<String>>();
  CliniquerProvider cliniqueMainProvider = new CliniquerProvider();
  getCliniques() {
    cliniqueMainProvider.get_clinique().whenComplete(() {
      setState(() {
        global_cliniques = cliniqueMainProvider.getCliniques();
        global_cliniques.forEach((clinique) {
          print(clinique.id);
          getVetos(clinique.id);
        });
      });
    });
  }

  getVetos(id_cl) {
    print("accessing get vetos");
    print(id_cl);
    cliniqueMainProvider.get_vetos(id_cl).whenComplete(() {
      setState(() {
        vetos_by_cl[id_cl] = cliniqueMainProvider.getVetos();
        dropDown_uniques[id_cl] = null;
      });
      vetos_by_cl.forEach((b, a) {
        print("SHOWING VETEIRINAIRES OF CLiNIQue $b");
        vetos_by_cl[b].forEach((veterinaire) {
          print(veterinaire.vEmail);
        });
      });
    });
  }

  @override
  void initState() {
    ///this function will call the api and render the data
    ///to show
    getCliniques();
    // getVetos(1);

    // menuItems = getNames();
    // get_clinique();
    super.initState();
  }

  Widget build(BuildContext context) {
    // setState(() {
    //   cliniqueMainProvider = Provider.of<CliniquerProvider>(context);
    //   global_cliniques = cliniqueMainProvider.getCliniques();
    //   print(global_cliniques.length);
    // });
    global_cliniques = cliniqueMainProvider.getCliniques();

    return RefreshIndicator(
      onRefresh: ,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("SliverAppBar Title"),
            ),
            SliverToBoxAdapter(
                child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2)),
                  height: 150,
                  alignment: Alignment.center,
                  child: DropdownButton(
                    disabledHint: new Text("No data to show"),
                    value: currenxt_id_cl2,
                    hint: Text('List des cliniques'),
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        currenxt_id_cl2 = value;
                      });
                    },
                    items: global_cliniques
                        .map<DropdownMenuItem<String>>((Clinique f) {
                      return DropdownMenuItem<String>(
                          child: Text(f.id.toString()), value: f.id.toString());
                    }).toList(),
                  ),
                ),
                RaisedButton(
                  child: Text("Delete selected item"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          actions: <Widget>[
                            RaisedButton(
                              child: Text("confirmer la supprission"),
                              onPressed: () {
                                print(currenxt_id_cl2);
                                setState(() {
                                  global_cliniques.removeWhere((clinique) =>
                                      clinique.id ==
                                      int.parse(currenxt_id_cl2.toString()));
                                  if (global_cliniques.length > 0) {
                                    currenxt_id_cl2 =
                                        global_cliniques[0].id.toString();
                                  } else {
                                    currenxt_id_cl2 = null;
                                  }
                                });
                              },
                            ),
                            RaisedButton(
                              child: Text("annuler"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
                  },
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: global_cliniques.length,
                    itemBuilder: (context, int i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    "${global_cliniques[i].cliniqueNom}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF23C9FF),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                                ),
                                (vetos_by_cl[global_cliniques[i].id] == null)
                                    ? CircularProgressIndicator()
                                    : DropdownButton(
                                        focusColor: Color(0xffCCD5FF),
                                        elevation: 16,
                                        disabledHint:
                                            new Text("No data to show"),
                                        value: dropDown_uniques[
                                            global_cliniques[i].id],
                                        hint: Text(
                                          'List des veterinaires',
                                          style: TextStyle(
                                              color: Color(0xFFC884A6),
                                              fontSize: 18,
                                              letterSpacing: 1),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            print(value);
                                            dropDown_uniques[
                                                global_cliniques[i].id] = value;
                                          });
                                        },
                                        items:
                                            vetos_by_cl[global_cliniques[i].id]
                                                .map<DropdownMenuItem<String>>(
                                                    (Veterinaire f) {
                                          return DropdownMenuItem<String>(
                                              child: Text(f.vNom.toString()),
                                              value: f.id.toString());
                                        }).toList(),
                                      ),
                                Icon(
                                  Icons.assignment,
                                  color: Color(0xff23C9FF),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    var test =
                                        vetos_by_cl[global_cliniques[i].id]
                                            .firstWhere((veterinaire) =>
                                                veterinaire.id ==
                                                (int.parse(dropDown_uniques[
                                                    global_cliniques[i].id])));
                                    print("you are deleting ${test.vNom}");
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Color(0xff82968C),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              indent: 30,
                              endIndent: 30,
                              color: Color(0xff82968C),
                              height: 10,
                            )
                          ],
                        ),

                        // Divider(color: Color(0xff82968C),height: 4,)
                      );
                    })
              ],
            ))
          ],
        ),
      ),
    );
  }
}
