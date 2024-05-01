import 'package:dianistana/components/button_color.dart';
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
          "images/bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.brown.withOpacity(0.3),
          body: Container(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                Row(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        color: Colors.transparent,
                      ),
                      child:
                          Image.asset("images/splash.png", fit: BoxFit.contain),
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
                  child: InkWell(
                    onTap: () {
                      _login.launchURL(
                          "https://api.whatsapp.com/send?phone=6282231353000&text=Saya%20Lupa%20Password%20aplikasi%20MyDianIstana%2C%20mohon%20dibantu%20untuk%20mereset%20password%0A%0ANama%3A%0ABlok%20%26%20Nomor%20Rumah%3A");
                    },
                    child: const Text("Forgot Password?",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: 'PoppinsBold', color: Colors.black)),
                  ),
                ),
                Jarak(tinggi: 50),
                Obx(
                  () => _login.loading.value
                      ? Center(
                          child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2)),
                          child: const Text("Processing....",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        ))
                      : InkWell(
                          splashColor: Colors.amber,
                          onTap: () {
                            _login.login(_username.text, _password.text);
                          },
                          child:
                              ButtonColor(text: "LOGIN", warna: Colors.green)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
