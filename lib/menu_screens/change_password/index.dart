import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/input_reguler.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/menu_screens/change_password/change_password_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  final ChangePasswordController _changePassword =
      Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("images/white_bg.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Jarak(tinggi: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: const Text("POWERED BY",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 10)),
                  ),
                  Image.asset(
                    "images/logo_line.png",
                    height: 22,
                  ),
                ],
              ),
              Jarak(tinggi: 30),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/left.png",
                        height: 30,
                        width: 30,
                      ),
                      Spasi(lebar: 10),
                      const Text("CHANGE PASSWORD",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: ListView(
                      children: [
                        Jarak(tinggi: 20),
                        InputReguler(
                            hint: "Enter your old password",
                            textInputType: TextInputType.text,
                            iconData: Icons.lock_outlined,
                            textEditingController: _oldPassword,
                            obsecureText: true),
                        Jarak(tinggi: 20),
                        InputReguler(
                            hint: "Enter your new password",
                            textInputType: TextInputType.text,
                            iconData: Icons.lock_open,
                            textEditingController: _newPassword,
                            obsecureText: true),
                        Jarak(tinggi: 20),
                        InputReguler(
                            hint: "Confirm your new password",
                            textInputType: TextInputType.text,
                            iconData: Icons.lock_reset,
                            textEditingController: _confirm,
                            obsecureText: true),
                        Jarak(tinggi: 30),
                        Obx(
                          () => _changePassword.loading.value
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
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 80),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red[900]),
                                      onPressed: () {
                                        _changePassword.changePassword(
                                            _oldPassword.text,
                                            _newPassword.text,
                                            _confirm.text);
                                      },
                                      child: const Text("Submit")),
                                ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
