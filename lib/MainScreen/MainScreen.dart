import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:office_managing_app/Profiles/UserProfile.dart';

class MainScreen extends StatefulWidget {
  static var routeName = '/Main-Screen';
  @override
  State<MainScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<MainScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore fStore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    final employeeButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          // _getCurrentUserDetail();
          // update();
        },
        child: const Text(
          "Employees",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
    final accountsButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>const MySellingScreen()));
        },
        child: const Text(
          "Accounts",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
    final projectsButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: const Text(
          "Projects",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
    final reportButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: const Text(
          "Reports",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black)),

        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile()));
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: const Icon(
              CupertinoIcons.person_alt_circle,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    employeeButton,
                    const SizedBox(height: 20),
                    accountsButton,
                    const SizedBox(height: 20),
                    projectsButton,
                    const SizedBox(height: 20),
                    reportButton,
                  ],
                ),

              ),
            ),
          ),
        ),
      )
    );
  }

  Future<void> signOut()async {
    await _auth.signOut();
    // Navigator.pop(context);
  }

}
/*Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color:const Color(0xff312b20),
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signOut();
          },
          child: const Text("LogOut", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
        ),
      ),*/