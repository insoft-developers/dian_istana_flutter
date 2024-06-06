import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/main_screen/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

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
          bottom: -60,
          left: 60,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10)),
            child: Image.asset(
              "images/black_bg.png",
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              margin: const EdgeInsets.only(top: 450, left: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Welcome, ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 12)),
                      Spasi(lebar: 5),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const LoginPage());
                        },
                        child: const Text("Login ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
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
                  const Text("Forgot Password? ",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 12)),
                  Jarak(tinggi: 8),
                  Row(
                    children: [
                      const Text("New User? ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 12)),
                      Spasi(lebar: 5),
                      const Text("Sign Up. ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
