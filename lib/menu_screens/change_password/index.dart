import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/input_reguler.dart';
import 'package:dianistana/components/jarak.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                    : InkWell(
                        onTap: () {
                          _changePassword.changePassword(_oldPassword.text,
                              _newPassword.text, _confirm.text);
                        },
                        child: ButtonColor(
                            text: "Submit",
                            warna: Colors.green.withOpacity(0.6))),
              )
            ],
          )),
    );
  }
}
