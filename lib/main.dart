import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'uSignIn.dart';
import 'uSignUp.dart';
import 'HomePage.dart';
import 'editinfo.dart';

void main() async {
  /*
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      CityEvents(city_name: e.value)));*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Login',
      theme: ThemeData(),
      routes: {
        '/': (BuildContext context) => SignIn(),
        '/signin': (BuildContext context) => SignIn(),
        '/home': (BuildContext context) => HomePage(),
        '/signup': (BuildContext context) => SignUp(),
        '/editinfo': (BuildContext context) => EditInfo(),
        //'/addevent': (BuildContext context) => AddEvent(city_name: '',),
      },
    );
  }
}
