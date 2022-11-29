import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/add_video_screen.dart';

/// Colors

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];

/// Firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

/// Controller

var authController = AuthController.instance;

/// Screens

final screens = [
  const Text('Home screen'),
  const Text('Search screen'),
  const AddVideoScreen(),
  const Text('Message screen'),
  const Text('Profile screen'),
];
