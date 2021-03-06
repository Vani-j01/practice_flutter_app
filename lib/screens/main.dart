import 'package:flutter/material.dart';
//import this to implement flutterfire
import 'package:firebase_core/firebase_core.dart';
import 'package:practice_flutter_app/screens/homepage.dart';
import 'package:practice_flutter_app/widgetsandfunctions/dart/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Flutter Demo"),
            ),
            body: child, //this child is dynamically replaced with corresponding page when we navigate
          );
        },
      theme: ThemeData(
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot){
          //Check for errors
          if(snapshot.hasError){
            return Scaffold(
              body: Center(
                child: Text("Error ${snapshot.error}"),
              ),
            );
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return HomePage();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Scaffold(
            body: Center(
              child: Text("Connecting to the app..."),
            ),
          );


        }
        );
  }
}
