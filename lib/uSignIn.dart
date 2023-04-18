import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  /* Intialize FirebaseAuth & GoogleSignIn and give an instance */

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /* Creating key to check FormState(status) */

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  /* Checking whether the user is logged in or not when App starts */

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      // if (user != null) {
      //   Navigator.pushReplacementNamed(context, '/home');
      // }
    });
  }

  /* Method for Navigation to Sign Up page (optional) */

  //navigateToSignUpScreen() {
  //  Navigator.pushReplacementNamed(context, '/signup');
  //}

  /* Whenever App starts/restarts i.e. a lifecylce finishes 
     and starts again following methods are executed   
  */

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  /* Method to check whether the user is signed in 
     after all the validation of form is done 
  */

  void signin() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        print("email " + _email);
        print("password " + _password);

        final snapShot = await FirebaseFirestore.instance
            .collection('users')
            .doc(_email)
            .get();
        print(snapShot.exists);
        if (snapShot.exists) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  /* Showing the error message */

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
//      appBar: AppBar(
//        title: Text('Sign In'),
//      ),
      body: Container(
        //padding: EdgeInsets.fromLTRB(100, 100, 100, 100),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 200,
                        height: 200,
                        padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
                        child: Image.asset('assets/logo.jpeg')),
                    Text(
                      'התחברות למערכת זמן לזיכרון',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 26.0, color: Colors.black),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            // E-mail TextField
                            Container(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.black,
                                initialValue: 'manu@mail.com',
                                style: TextStyle(color: Colors.white),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'Provide an email';
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.black,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.white38,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'אימייל'),
                                onSaved: (input) => _email = input!,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            // Password TextField
                            Container(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.black,
                                initialValue: '',
                                style: TextStyle(color: Colors.white),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'Provide an email';
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.black,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.white38,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'סיסמה'),
                                onSaved: (input) => _password = input!,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 60),
                            ),
                            //  Sign In button
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(30),
                                  ),
                                ),
                                onPressed: signin,
                                child: Text(
                                  'היכנס',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/signup');
                                },
                                child: Text(
                                  'הרשמה',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            // Text Button to Sign Up page
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
