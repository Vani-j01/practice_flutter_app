import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter_app/screens/websockets.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Container(
          child:
          GridView.count(
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            crossAxisCount: 3,

            children: [
              MaterialButton(
                child: Text("Login"),
                  onPressed:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }
              ),
              MaterialButton(
                child: Text("Websockets"),
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Websockets()),
                  );
                }),
              MaterialButton(
                  child: Text("Notification"),
              ),
              MaterialButton(
                child: Text("Loading images"),
              ),
              MaterialButton(
                child: Text("Storing info to firebase"),
              ),
              MaterialButton(
                child: Text("Navbars+slideshow"),
              ),
            ],

          ),
        ),

    );
  }
}
