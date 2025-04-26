import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
FirebaseAuth firebaseAuth=FirebaseAuth.instance;
var senderId=FirebaseAuth.instance.currentUser!.uid;

var themecolor=Color(0xff1a444f);

