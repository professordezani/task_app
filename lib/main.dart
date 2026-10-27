import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'task-list.dart';
import 'task-create.dart';
import 'user-login.dart';
import 'user-register.dart';

const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyAGKLLZVT76qrR2elSm2PUUlSBdXjJ2u6k",
    authDomain: "taskapp-37d25.firebaseapp.com",
    projectId: "taskapp-37d25",
    storageBucket: "taskapp-37d25.firebasestorage.app",
    messagingSenderId: "586817067052",
    appId: "1:586817067052:web:6544e612e74a842a15d989");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/lista": (context) => TaskListPage(),
        "/create": (context) => TaskCreatePage(),
        "/login": (context) => UserLoginPage(),
        "/register": (context) => UserRegisterPage(),
      },
      initialRoute: user == null ? "/login" : "/lista",
    );
  }
}
