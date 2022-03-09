
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:office_managing_app/MainScreen/MainScreen.dart';

import 'Register.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState()=>_LoginScreen();
}

class _LoginScreen extends State<LoginScreen>{
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isHidden = true;
  bool iaLoading = false;
  @override
  Widget build(BuildContext context) {
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
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return("Password is required");
        }
        if(!regex.hasMatch(value)){
          return("Enter Valid Password(Min. 6 Characters)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            icon:
            isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: togglePasswordVisibility,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      obscureText: isHidden,
    );
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.only(left: 10,right: 10),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          setState(() {
            iaLoading = true;
          });
          Future.delayed(const Duration(seconds: 3),(){
            setState(() {
              iaLoading = false;
            });
          });
          signIn(emailEditingController.text,passwordController.text);
        },
        child: iaLoading? CircularProgressIndicator(color: Colors.white,): const Text("Login", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
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
                      height: 200,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black,
                            fontSize: 80, fontWeight: FontWeight.bold),
                      ),
                      /*Image.asset("Login",fit: BoxFit.contain,)*/
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    emailField,
                    const SizedBox(
                      height: 25,
                    ),
                    passwordField,
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (context) => ForgotPassword()));
                            },
                            child: const Text("Forgot Your Password?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    loginButton,
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account? "),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => Register()));
                            },
                            child: const Text("SingUp",
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

  void signIn(String email,String password)async{
    if(_formKey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value){
        Fluttertoast.showToast(msg: "Login Successfully");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }



  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}