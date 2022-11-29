import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'firebaseAuth.dart';
import 'package:rcroom/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value (
      initialData: null,
      value: signInUp().user,
      child: MaterialApp(home: wrapper(),)
    );
  }
}

class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInformation = Provider.of<User?>(context);
    if (userInformation==null){
      return rcRoom();
    }
    else{
      return homepage();
    }
  }
}


class rcRoom extends StatelessWidget {
  const rcRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: new MediaQueryData(),
    child:loginSignUp());
  }
}

class loginSignUp extends StatefulWidget {
  const loginSignUp({Key? key}) : super(key: key);

  @override
  State<loginSignUp> createState() => _loginSignUpState();
}

class _loginSignUpState extends State<loginSignUp> {

  bool isSignIn = false;
  String message = "Log in here!";
  String signinButtonText = 'Login!';
  String change = 'Don\'t have and account yet? Sign up here!';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  changeSignIn() {
    setState(() {
      if (isSignIn == false) {
        isSignIn = true;
        message = "Log in here!";
        change = "Don't have and account yet? Sign up here!";
        signinButtonText = "Login!";
      } else {
        isSignIn = false;
        message = "Sign up here!";
        change = "Log in to existing account!";
        signinButtonText = "Sign up!";
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final _auth=signInUp();
    acc() async{
      var email=emailController.text.trim();
      var password=passwordController.text.trim();
      if (isSignIn == false) {
        await _auth.signUp(email,password);
        isSignIn == false;
        print(email);
        print(password);
      } else {
        await _auth.signIn(email,password);
        isSignIn == true;
      }
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return MaterialApp(
        home: Scaffold( resizeToAvoidBottomInset:false,
            appBar: AppBar(title: const Text("rcroom")),
            body:Container(
                padding: EdgeInsets.only(top: height * 0.2),
                width: double.infinity,
                height: double.infinity,
                color: Colors.cyan,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: height * 0.15),
                            child: Text("okay",
                                style: TextStyle(fontSize: height * 0.05)),
                          ),
                          Container(
                            child: TextFormField(
                              controller: emailController,
                              obscureText: false,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_circle_outlined),
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(60.0)),
                                  borderSide: const BorderSide(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * 0.02),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock_outline),
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(60.0)),
                                    borderSide: BorderSide(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              )),
                          Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    acc();
                                  },
                                  child: Text(signinButtonText)),
                              Text(message),
                              TextButton(onPressed: changeSignIn, child: Text(change)),
                            ],
                          ),
                        ])))));
  }
}
