import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _firstname = '';
  String _lastname = '';
  String _email = '';
  String _phone = '';
  String _username = '';
  String _password = '';
  String _usertype = '';

  checkAuthincation() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  navigateToSignInScreen() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthincation();
  }

  signup() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      try {
        var user = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        if (user != null) {
          await FirebaseAuth.instance.currentUser!
              .updateProfile(displayName: _firstname);
        }

        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        users.doc(_email).set({
          'first name': _firstname,
          'last_name': _lastname,
          'phone': _phone,
          'user name': _username,
          'email': _email
        });

        Navigator.of(context).pushNamed('/home');
      } catch (e) {
        showError(e.toString());
      }
    }
  }

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
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
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
                      'הרשמה למערכת זמן לזיכרון',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 26.0, color: Colors.black),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
//                        Name box
                            Container(
                              child: TextFormField(
                                maxLength: 10,
                                textCapitalization:
                                    TextCapitalization.characters,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.white),
                                // ignore: missing_return
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'חייב למלא';
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
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.blue,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'שם פרטי'),
                                onSaved: (input) => _firstname = input!,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Container(
                              child: TextFormField(
                                maxLength: 10,
                                textCapitalization:
                                    TextCapitalization.characters,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.white),
                                // ignore: missing_return
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'חייב למלא';
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
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.blue,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'שם משפחה'),
                                onSaved: (input) => _lastname = input!,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Container(
                              child: TextFormField(
                                maxLength: 10,
                                textCapitalization:
                                    TextCapitalization.characters,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.white),
                                // ignore: missing_return
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'חייב למלא';
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
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.blue,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'טלפון'),
                                onSaved: (input) => _phone = input!,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Container(
                              child: TextFormField(
                                maxLength: 10,
                                textCapitalization:
                                    TextCapitalization.characters,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.white),
                                // ignore: missing_return
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'חייב למלא';
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
                                      Icons.people,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.blue,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'שם משתמש'),
                                onSaved: (input) => _username = input!,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Container(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                // ignore: missing_return
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "provide an email";
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
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.blue,
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
                              padding: EdgeInsets.all(5),
                            ),
                            Container(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                // ignore: missing_return
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white38),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.blue,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'סיסמה'),
                                onSaved: (input) => _password = input!,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),

                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                                  backgroundColor: Colors.black45,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(30),
                                  ),
                                ),
                                onPressed: signup,
                                child: Text(
                                  'הירשם',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),

                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            GestureDetector(
                              onTap: navigateToSignInScreen,
                              child: Text(
                                'יש לכם כבר חשבון? לחצו להתחברות',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black45),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
