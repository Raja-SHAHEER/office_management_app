
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:office_managing_app/ModelClasses/UserModel.dart';

import 'LoginScreen.dart';

class Register extends StatefulWidget{
  static const String id = "Register";
  Register({Key? key,}) : super(key: key);

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register>{
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  var contactEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  bool isHidden = true;
  bool isHidden1 = true;
  bool iaLoading = false;
  @override
  Widget build(BuildContext context) {

    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Name Field cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Name(Min. 3 Characters)");
        }
      },
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter Valid Email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    final contactField = TextFormField(
      // autofocus: false,
      // enabled: false,
      inputFormatters: [LengthLimitingTextInputFormatter(11)],
      controller: contactEditingController,
      keyboardType: TextInputType.phone,
      validator: (value){
        RegExp regex = RegExp(r'^.{11,}$');
        if(value!.isEmpty){
          return("Please enter your contact no");
        }
        if (!regex.hasMatch(contactEditingController.text)) {
          return ("Enter Valid Phone Number(Min.11 Characters)");
        }
        if(!RegExp("^[0-9+]+[0-9]").hasMatch(value)){
          return("Please Enter Valid Mobile");
        }

      },
      onSaved: (value) {
        contactEditingController.text = value!;
      },

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contact Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Characters)");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            icon: isHidden
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
            onPressed: togglePasswordVisibility,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      obscureText: isHidden,
    );
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      validator: (value) {
        if(value!.isEmpty){
          return('Confirm Password is required');
        }
        if (confirmPasswordEditingController.text != passwordEditingController.text) {
          return ("Password is not matching");
        }
        // return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            icon: isHidden1
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
            onPressed: togglePasswordVisibility1,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      obscureText: isHidden1,
    );
    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.only(left: 10,right: 10),
        height: 50,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          setState(() {
            iaLoading = true;
          });
          Future.delayed(const Duration(seconds: 4),(){
            setState(() {
              iaLoading = false;
            });
          });
          signUp(emailEditingController.text,passwordEditingController.text);
        },
        child: iaLoading? CircularProgressIndicator(color: Colors.white,): const Text(
          "SignUp", textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      /*Image.asset("Login",fit: BoxFit.contain,)*/
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    nameField,
                    const SizedBox(
                      height: 20,
                    ),
                    emailField,
                    const SizedBox(
                      height: 20,
                    ),
                    contactField,
                    const SizedBox(
                      height: 20,
                    ),
                    passwordField,
                    const SizedBox(
                      height: 20,
                    ),
                    confirmPasswordField,
                    const SizedBox(
                      height: 20,
                    ),
                    registerButton,
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Already have an account? "),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: const Text("SingIn",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  void signUp(String email,String password) async{
    if (_formKey.currentState!.validate()) {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
        postDetailsToFirestore();
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
  void postDetailsToFirestore() async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.name = nameEditingController.text;
    userModel.email = user!.email;
    userModel.contact = contactEditingController.text;
    userModel.password = passwordEditingController.text;
    userModel.cnfrmPassword = confirmPasswordEditingController.text;
    userModel.uid = user.uid;
    await firestore.collection("users").doc(user.uid).set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account Created Successfully ");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    return;
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
  void togglePasswordVisibility1() => setState(() => isHidden1 = !isHidden1);
}