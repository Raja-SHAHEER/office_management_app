import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  static const String id = "UserProfile";
  static var routeName = '/UserProfile';

  final userId;

  UserProfile({Key? key, this.userId}) : super(key: key);

  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
    );
  }

}