import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leading: const BackButton(
        color: Colors.green,
      ),
      backgroundColor: Colors.white,
      title: const Text(
        "Profile",
        style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
      ),
    ));
  }
}
