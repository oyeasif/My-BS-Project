import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences? sharedPreferences;

  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static var user;
  static String currentuserid = "null";

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Color textcolor = Colors.white;

}