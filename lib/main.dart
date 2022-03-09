import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:office_managing_app/SplashScreen/SplashScreen.dart';
FirebaseFirestore? fStore;
Future<void> main() async {
  final FirebaseApp firestore;
  WidgetsFlutterBinding.ensureInitialized();
  firestore = await Firebase.initializeApp();
  fStore = FirebaseFirestore.instanceFor(app: firestore);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
