import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_flutter_app/screens/homepage.dart';
import 'package:practice_flutter_app/screens/logout.dart';

class AuthService{
  //Handles Auth
  handelAuth(){
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return Logout();
          }
          else{
            return HomePage();
          }

    });
  }

  //SignOut
signOut(){
    FirebaseAuth.instance.signOut();
}

//SignIn
signIn(AuthCredential authCredential){
    FirebaseAuth.instance.signInWithCredential(authCredential);
}
}