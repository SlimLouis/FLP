import 'package:flutter/material.dart';
import 'package:vet_project/models/vets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _selectedColor;

  int selected;

  bool loading;
  @override
  void initState() {
    // TODO: implement initState7
    selected=1;
    _selectedColor = Colors.green;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.centerLeft,
                // end: Alignment.centerRight,
                colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SOS VETO",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 45),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      iconSize: 300,
                      onPressed: () {
                        setState(() {
                          selected = 1;
                        });
                      },
                      icon: CircleAvatar(
                        radius: (height + width) * 0.07,
                        backgroundColor: (selected == null)
                            ? null
                            : (selected == 1) ? _selectedColor : null,
                        child: ClipOval(
                          child: Image.network(
                              "https://www.conference2go.com/wp-content/uploads/2019/02/veterinary.png",
                              width: 300,
                              height: 300),
                        ),
                      ),
                    ),
                    Text(
                      "Veterinaire",
                      style: TextStyle(
                          fontSize: 18,
                          color: (selected == null)
                              ? null
                              : (selected == 1) ? _selectedColor : null),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      iconSize: 300,
                      onPressed: () {
                        setState(() {
                          selected = 2;
                        });
                      },
                      icon: CircleAvatar(
                        backgroundColor: (selected == null)
                            ? null
                            : (selected == 2) ? _selectedColor : null,
                        radius: (height + width) * 0.07,
                        child: ClipOval(
                          child: Image.network(
                            "https://cdn1.iconfinder.com/data/icons/user-icon-profile-businessman-finance-vector-illus/100/01-1User-2-512.png",
                            width: 300,
                            height: 300,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Administrateur",
                      style: TextStyle(
                          fontSize: 18,
                          color: (selected == null)
                              ? null
                              : (selected == 2) ? _selectedColor : null),
                    )
                  ],
                ),
              ],
            ),
           RaisedButton(
              child: Text("Continue as ${(selected==1 ? "veterinaire" : "administrateur")}") ,
              onPressed: () {
               
                Navigator.pushNamed(context, '/login');
              },
            )
          ],
        ),
      ),
    );
  }
}
