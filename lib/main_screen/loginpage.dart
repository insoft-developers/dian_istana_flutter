import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/button_login.dart';
import 'package:dianistana/components/input_login.dart';
import 'package:dianistana/components/input_text.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/controllers/login_controller.dart';
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
  final LoginController _login = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/white_bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 460,
          left: 30,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
            child: Image.asset(
              "images/black_bg.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Jarak(tinggi: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      "images/logo_line.png",
                      height: 30,
                    ),
                  ),
                ],
              ),
              Jarak(tinggi: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            margin: const EdgeInsets.only(left: 60, top: 70),
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(75),
                            ),
                            child: Image.asset("images/splash2.png",
                                fit: BoxFit.cover),
                          ),
                          Spasi(lebar: 10),
                        ],
                      ),
                      Jarak(tinggi: 10),
                      const Center(
                          child: Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'RubikBold',
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      )),
                      Jarak(tinggi: 70),
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: InputLogin(
                            hint: "Username",
                            textInputType: TextInputType.text,
                            iconData: Icons.account_circle_outlined,
                            textEditingController: _username,
                            obsecureText: false),
                      ),
                      Jarak(tinggi: 15),
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: InputLogin(
                            hint: "Password",
                            textInputType: TextInputType.text,
                            iconData: Icons.lock_outline,
                            textEditingController: _password,
                            obsecureText: true),
                      ),
                      Jarak(tinggi: 60),
                      Row(
                        children: [
                          Obx(
                            () => _login.loading.value
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 40, right: 30),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2)),
                                    child: const Text("Processing....",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: InkWell(
                                        splashColor: Colors.amber,
                                        onTap: () {
                                          _login.login(
                                              _username.text, _password.text);
                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: ButtonLogin(
                                              text: "Login",
                                              warna: const Color.fromARGB(
                                                  255, 97, 5, 5)),
                                        )),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _login.launchURL();
                            },
                            child: const Text("Forgot Password?",
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Colors.white,
                                    fontSize: 12)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
