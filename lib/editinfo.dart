import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ffi';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class EditInfo extends StatefulWidget {
  @override
  _EditInfo createState() => _EditInfo();
}

String imagetext = "";
String _data = "";

class _EditInfo extends State<EditInfo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  String user_first_name = "";
  String user_last_name = "";
  String user_phone = "";
  String user_email = "";
  String user_name = "";
  Query _firebaseStream = FirebaseFirestore.instance.collection('cities');
  bool isSignedIn = false;

  int randomNumber = Random().nextInt(9999999);
  var picker = ImagePicker();
  var docs = []; // variable in state
  String? _lastId;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushNamed(context, '/');
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      if (mounted) {
        setState(() {
          this.user = firebaseUser!;
          this.isSignedIn = true;
        });
      }
    }
  }

  signout() async {
    _auth.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    user_first_name = get_user_first_name();
    user_last_name = get_user_last_name();
    user_email = get_user_email();
    user_name = get_user_user_name();
    user_phone = get_user_phone();

    this.getUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("זמן לזיכרון"),
        actions: [
          IconButton(
            alignment: Alignment.topCenter,
            icon: const Icon(
              Icons.exit_to_app_rounded,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "צפיה בפרטים אישיים",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    user_first_name,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    ":שם פרטי",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    user_last_name,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    ":שם משפחה",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    user_phone,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    ":טלפון",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    user_email,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    ":אימייל",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    user_name,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    ":שם משתמש",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "אין פרופילים בניהול כרגע",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    " פרופילים מנוהלים",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.add),
              tooltip: 'הבקשה התקבלה',
              onPressed: () {},
            ),
            Text(
              'להוספת פרופיל חדש לנפטר',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String get_user_first_name() {
    String found = "";
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((DocumentSnapshot ds) {
      user_first_name = ds.get('first name');
    });
    return user_first_name;
  }

  String get_user_last_name() {
    String found = "";
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((DocumentSnapshot ds) {
      user_last_name = ds.get('last_name');
    });
    return user_last_name;
  }

  String get_user_phone() {
    String found = "";
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((DocumentSnapshot ds) {
      user_phone = ds.get('phone');
    });
    return user_phone;
  }

  String get_user_email() {
    String found = "";
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((DocumentSnapshot ds) {
      user_email = ds.get('email');
    });
    return user_email;
  }

  String get_user_user_name() {
    String found = "";
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((DocumentSnapshot ds) {
      user_name = ds.get('user name');
    });
    return user_name;
  }
}
