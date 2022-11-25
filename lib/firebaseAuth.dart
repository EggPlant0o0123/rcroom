import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

class signInUp {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user!=null) {
        String uid = user.uid;
        print(uid);
        return uid;
      }
      else{
        print("email or password wrong");
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future signUp(email,password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user!=null) {
        String uid = user.uid;
        print(uid);
        return uid;
      }
      else{
        return null;
      }
    }catch(e){
      return null;
    }
  }
}