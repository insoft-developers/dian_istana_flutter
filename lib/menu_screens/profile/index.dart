import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/input_readonly.dart';
import 'package:dianistana/components/input_reguler.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/select.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/controllers/login_controller.dart';
import 'package:dianistana/menu_screens/change_password/index.dart';
import 'package:dianistana/menu_screens/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profile = Get.put(ProfileController());
  final LoginController _logins = Get.put(LoginController());
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _emergency = TextEditingController();
  final TextEditingController _level = TextEditingController();
  final TextEditingController _pdam = TextEditingController();
  final TextEditingController _pln = TextEditingController();

  @override
  void initState() {
    _profile.resetPicker();
    _profile.getUserData().then((value) {
      _name.text = _profile.userData['name'].toString();
      _username.text = _profile.userData['username'].toString();
      _email.text = _profile.userData['email'].toString();
      _phone.text = _profile.userData['no_hp'].toString();
      _profile
          .changeSelectedGender(_profile.userData['jenis_kelamin'].toString());
      _emergency.text = _profile.userData['whatsapp_emergency'].toString();
      _level.text = _profile.userData['level'].toString();
      _pdam.text = _profile.userData['id_pelanggan_pdam'].toString();
      _pln.text = _profile.userData['nomor_meter_pln'].toString();
    });
    super.initState();
  }

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
                Jarak(tinggi: 50),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Text("POWERED BY",
                          style: TextStyle(fontFamily: 'Rubik', fontSize: 10)),
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
                        const Text("PROFILE",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(30),
                      child: Obx(() => _profile.loading.value
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : ListView(children: [
                              Stack(children: [
                                Image.asset(
                                  "images/top_userdata.png",
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  height: 100,
                                ),
                                Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7))),
                                GetBuilder<ProfileController>(
                                    builder: (builderController) {
                                  return Center(
                                    child: builderController.pickedFile != null
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 3.0,
                                                    color: Colors.green),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: Image.file(
                                                  File(builderController
                                                      .pickedFile!.path),
                                                  fit: BoxFit.cover),
                                            ),
                                          )
                                        : builderController.userData["foto"] !=
                                                null
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 3.0,
                                                        color: Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  child: CachedNetworkImage(
                                                      imageUrl: Constant
                                                              .PROFILE_IMAGE +
                                                          _profile
                                                              .userData['foto']
                                                              .toString(),
                                                      fit: BoxFit.cover),
                                                ),
                                              )
                                            : Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 3.0,
                                                        color: Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  child: Image.asset(
                                                      "images/logo.png",
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                  );
                                }),
                                Positioned(
                                  right: 110,
                                  top: 50,
                                  child: InkWell(
                                    onTap: () {
                                      _profile.pickImage();
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Icon(Icons.edit)),
                                  ),
                                )
                              ]),
                              Jarak(tinggi: 20),
                              InputReadonly(
                                  hint: "enter name",
                                  textInputType: TextInputType.name,
                                  iconData: Icons.account_circle_outlined,
                                  textEditingController: _name,
                                  obsecureText: false),
                              Jarak(tinggi: 15),
                              InputReadonly(
                                  hint: "enter username",
                                  textInputType: TextInputType.text,
                                  iconData: Icons.verified_user_outlined,
                                  textEditingController: _username,
                                  obsecureText: false),
                              Jarak(tinggi: 15),
                              InputReguler(
                                  hint: "enter your email",
                                  textInputType: TextInputType.emailAddress,
                                  iconData: Icons.email_outlined,
                                  textEditingController: _email,
                                  obsecureText: false),
                              Jarak(tinggi: 15),
                              InputReguler(
                                  hint: "enter your whatsapp number",
                                  textInputType: TextInputType.phone,
                                  iconData: Icons.whatsapp_outlined,
                                  textEditingController: _phone,
                                  obsecureText: false),
                              Jarak(tinggi: 15),
                              Obx(
                                () => Select(
                                    defValue: _profile.genderDefaultValue.value,
                                    hint: "",
                                    menuItems: _profile.dropdownGender,
                                    code: "gender_selection",
                                    iconData: Icons.man_outlined),
                              ),
                              Jarak(tinggi: 15),
                              InputReguler(
                                  hint: "enter your whatsapp emergency number",
                                  textInputType: TextInputType.phone,
                                  iconData: Icons.phone_outlined,
                                  textEditingController: _emergency,
                                  obsecureText: false),
                              Jarak(tinggi: 15),
                              InputReadonly(
                                  hint: "enter level",
                                  textInputType: TextInputType.text,
                                  iconData: Icons.grade_outlined,
                                  textEditingController: _level,
                                  obsecureText: false),
                              Jarak(tinggi: 15),
                              InputReguler(
                                  hint: "enter ID PDAM",
                                  textInputType: TextInputType.text,
                                  iconData: Icons.water_outlined,
                                  textEditingController: _pdam,
                                  obsecureText: false),
                              Jarak(tinggi: 15),
                              InputReguler(
                                  hint: "enter ID PLN",
                                  textInputType: TextInputType.text,
                                  iconData: Icons.flash_on_outlined,
                                  textEditingController: _pln,
                                  obsecureText: false),
                              Jarak(tinggi: 30),
                              Obx(
                                () => _profile.updateLoading.value
                                    ? Center(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                          child: const Text("Processing....",
                                              style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 15,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 60),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red[900]),
                                            onPressed: () {
                                              _profile.profileUpdate(
                                                  _email.text,
                                                  _phone.text,
                                                  _emergency.text,
                                                  _pdam.text,
                                                  _pln.text);
                                            },
                                            child: const Text("UPDATE")),
                                      ),
                              ),
                              Jarak(tinggi: 40),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => const ChangePasswordPage());
                                  },
                                  child: const Text("Change Password",
                                      style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                              Jarak(tinggi: 20),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _logins.logout();
                                  },
                                  child: const Text("LOGOUT",
                                      style: TextStyle(
                                          fontFamily: 'RubikBold',
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                              Jarak(tinggi: 50),
                            ]))),
                ),
              ],
            )),
      ],
    );
  }
}
