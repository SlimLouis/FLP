import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vet_project/main.dart';
import 'package:vet_project/models/Rendez-vous.dart';

class CalendarWidget extends StatefulWidget {
  
  const CalendarWidget({Key key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarController _calendarController = new CalendarController();
  Map<DateTime, List<Rendezvous>> event_ =
      new Map<DateTime, List<Rendezvous>>();
  @override
  void initState() {
    Rendezvous r1 = new Rendezvous(
        date: DateTime(2020, 2, 16), id: 1, nom: "amir", prenom: "benasr");
    Rendezvous r2 = new Rendezvous(
        date: DateTime(2020, 2, 17), id: 2, nom: "sorour", prenom: "benasr");
    Rendezvous r3 = new Rendezvous(
        date: DateTime(2020, 5, 5), id: 3, nom: "mourad", prenom: "benasr");
    Rendezvous r4 = new Rendezvous(
        date: DateTime(2020, 2, 18),
        id: 4,
        nom: "abdelhamid",
        prenom: "benasr");

    liste_rendezvous.add(r1);
    liste_rendezvous.add(r2);
    liste_rendezvous.add(r3);
    liste_rendezvous.add(r4);

    List<String> list_date = new List<String>();

    event_ = Map.fromIterable(liste_rendezvous,
        key: (e) => e.date,
        value: (e) => new List<Rendezvous>.from([Rendezvous(nom: e.nom)]));

    event_.forEach((k, v) {
      print(event_[k].length);
    });
    //Map<DateTime,List<String> event_map = {DAteT}
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        drawer: Drawer(
          elevation: 5,
          child: ListView(

            children: <Widget>[
              ListTile(
                onTap: ()
                {
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyStatefulWidget()));
                },
                contentPadding: EdgeInsets.all(8),
                title: Text("Collaborateurs"),
                leading: Icon(Icons.hourglass_empty),
              )
            ],
          ),
        ),
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.green),
          actions: <Widget>[],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(border: Border.all()),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 5)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Liste des Rendez-Vous",
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        height: 40,
                      ),
                      TableCalendar(
                        events: event_,
                        builders: CalendarBuilders(
                            markersBuilder: (context, date, events, holiday) {
                          var children = <Widget>[];
                          int counter = event_[date].length;
                          children.add(Positioned(
                            bottom: 1,
                            right: 1,
                            child: Text("$counter"),
                          ));
                          return children;
                        }),
                        calendarController: _calendarController,
                        locale: 'fr_FR',
                        onDaySelected: (date, events) {
                          setState(() {
                            current_date_selected = date;
                          });
                          // print(date.);
                          String dateinFormat =
                              DateFormat('dd-MM-yyyy').format(date);
                          var comp = dateinFormat.compareTo('16-02-2020');
                          if (comp == 0) {
                            addRendezvous();
                          } else {
                            clearRendezvous();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                color: Colors.grey,
                thickness: 2,
                indent: 50,
                endIndent: 50,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Center(
                          child: Container(
                              child: DropdownButton(
                        isExpanded: true,
                        hint: Center(child: Text("Liste des collaborateurs")),
                      ))),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: liste_rendezvous.length,
                          itemBuilder: (context, i) {
                            return rendezVousCardWidget(
                                i, liste_rendezvous[i], current_date_selected);
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /////entities
  List<Rendezvous> liste_rendezvous = new List();
  DateTime current_date_selected = DateTime.now();

  ///functinalities
  ///
  List<String> local_rendezvous = new List();
  void addRendezvous() {
    // print('added succesffuly');
    setState(() {
      local_rendezvous.add("RENDEZVOUS 1");
    });
    local_rendezvous.forEach((f) => print(f));
  }

  clearRendezvous() {
    print("accessing null");
    setState(() {
      local_rendezvous.clear();
    });
  }
}

bool dateToFormat(DateTime date1_, DateTime date2_) {
  String date1 = DateFormat('dd-MM-yyyy').format(date1_);
  String date2 = DateFormat('dd-MM-yyyy').format(date2_);
  // print(date1);
  // print(date2);
  var i = date1.compareTo(date2);
  // print(i);
  if (date1.compareTo(date2) == 0)
    return true;
  else
    return false;
}

Widget rendezVousCardWidget(int i, Rendezvous rendezvous, DateTime date) {
  var textstyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
  if (dateToFormat(date, rendezvous.date) == true)
    return Container(
      child: Card(
        color: Colors.blue,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Client $i : ${rendezvous.nom + ' ' + rendezvous.prenom}',
                style: textstyle,
              ),
              Text(
                "Date : ${DateFormat('dd-MM-yyyy').format(rendezvous.date)}",
                style: textstyle,
              )
            ],
          ),
        ),
      ),
    );
  else {
    return Container();
  }
}
