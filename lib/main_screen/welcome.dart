import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/controllers/login_controller.dart';
import 'package:dianistana/main_screen/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);
  final LoginController _login = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("images/white_bg.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover),
        Positioned(
          top: 80,
          left: 60,
          child: Image.asset(
            "images/splash2.png",
            width: 180,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: -400,
          left: 60,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10)),
            child: Image.asset(
              "images/black_bg.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(),
            ),
            Positioned(
              bottom: 80,
              left: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Welcome, ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontSize: 12)),
                      Spasi(lebar: 5),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const LoginPage());
                        },
                        child: const Text("Login ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                      Image.asset(
                        "images/play.png",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  Jarak(tinggi: 20),
                  GestureDetector(
                    onTap: () {
                      _login.launchURL();
                    },
                    child: const Text("Forgot Password? ",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontSize: 12)),
                  ),
                  Jarak(tinggi: 8),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
