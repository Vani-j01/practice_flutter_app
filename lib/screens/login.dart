import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter_app/widgetsandfunctions/dart/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  String _password, _email;
  int _count = 0;
  String phoneNo, verificationId;
  //form key
  final formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                  child: Text("Using Email"),
                  onPressed: () {
                    setState(() {
                      _count = 1;
                    });
                  }),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _count = 2;
                  });
                },
                child: Text("Using Phone"),
              ),
              MaterialButton(child: Text("Go back to home"), onPressed: () { Navigator.pop(context);}),
              createwidget(_count), //this is where i want the forms
            ],
          ),
        ),
      ),
    );
  }

  Widget createwidget(int count) {
    print("inside create");
    //Nothing is chosen
    if (count == 0) {
      print(_count);
      return new Text("Select an option");

      //for email login
    } else if (count == 1) {
      return new Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                bottom: 30.0,
              ),
              child: Text(
                "LOGIN",
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Email",
                labelText: "Email",
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter Password", labelText: "Password"),
              onChanged: (value) {
                _password = value;
              },
            ),
            Row(
              children: [
                TextButton(
                    onPressed: _createuser,
                    child: Text("Create account")),
                TextButton(
                    onPressed: _login,
                    child: Text("Login")),
              ],
            ),
          ],
        ),
      );
    }

    //Phone login
    if (_count == 2) {
      return new Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                bottom: 30.0,
              ),
              child: Text(
                "LOGIN",
                textAlign: TextAlign.center,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: "Enter Phone Number"),
              onChanged: (val){
                setState(() {
                  this.phoneNo= val;
                });
              },
            ),
            RaisedButton(
                child:  Center(
                  child: Text("Login"),
                ),
                onPressed: (){
              verifyPhone(phoneNo);
            })

          ],
        ),
      ));
    }
    if (_count == 3) {}
  }

//To create user account using email
  Future<void> _createuser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  //Login user using email
  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("b");
      print("Error: $e");
    }
  }

  //To Verify user using phone no.
  Future<void> verifyPhone(phoneNo) async{

    final PhoneVerificationCompleted verified = (AuthCredential authResult){
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException){
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]){
      this.verificationId= verId;
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId){
      this.verificationId= verId;
    };

    //Firebase function
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);


  }
}
