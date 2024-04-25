import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/input_text.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.white.withOpacity(0.3),
          body: Container(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                Row(
                  children: [
                    Image.asset("images/logo.png",
                        width: 30, height: 30, fit: BoxFit.cover),
                    Spasi(lebar: 10),
                    const Text("Welcome To \nMy Dian Istana",
                        style: TextStyle(
                            fontFamily: 'PoppinsBold',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 16)),
                  ],
                ),
                Jarak(tinggi: 60),
                const Center(
                    child: Text(
                  "Login To Your \nAccount",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                )),
                Jarak(tinggi: 50),
                InputText(
                    hint: "Username",
                    textInputType: TextInputType.text,
                    iconData: Icons.person,
                    textEditingController: _username,
                    obsecureText: false),
                Jarak(tinggi: 15),
                InputText(
                    hint: "Password",
                    textInputType: TextInputType.text,
                    iconData: Icons.lock,
                    textEditingController: _password,
                    obsecureText: true),
                Jarak(tinggi: 5),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Text("Forgot Password?",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'PoppinsBold', color: Colors.white)),
                ),
                Jarak(tinggi: 50),
                ButtonColor(text: "LOGIN", warna: Colors.green)
              ],
            ),
          ),
        )
      ],
    );
  }
}
