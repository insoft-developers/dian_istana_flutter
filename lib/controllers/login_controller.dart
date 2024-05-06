import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/main_screen/homepage.dart';
import 'package:dianistana/main_screen/loginpage.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  var userData = <String, dynamic>{}.obs;
  var loading = false.obs;
  var isAuth = false.obs;
  var tokenString = "".obs;
  var notifNumber = 0.obs;

  void updateNotifNumber() async {
    notifNumber.value = notifNumber.value + 1;
  }

  void updateFCMToken(String token) async {
    tokenString.value = token;
  }

  void updateTokenToUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {"id": userId, "token": tokenString.value};
      var res = await Network().auth(data, '/update_fcm_token');
      var body = jsonDecode(res.body);
      if (body['success']) {
        print(body);
      }
    }
  }

  void setLogin() {
    isAuth(true);
  }

  void checkLogin() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      isAuth(true);
    } else {
      isAuth(false);
    }
  }

  void login(String username, String password) async {
    loading(true);
    var data = {"username": username, "password": password};
    var res = await Network().auth(data, '/login');
    var body = jsonDecode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('user', json.encode(body['data']));
      localStorage.setString('token', json.encode(body['token']));
      showSuccess(body['message'].toString());
      loading(false);
      updateTokenToUser();
      Get.offAll(const HomePage());
    } else {
      showError(body['message'].toString());
      loading(false);
    }
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      localStorage.remove('user');
      localStorage.remove('token');
      Get.offAll(() => const LoginPage());
    }
  }

  void showError(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Html(
        data: n,
        defaultTextStyle: const TextStyle(
            color: Colors.white, fontFamily: 'Poppins', fontSize: 14),
      ),
    ));
  }

  void showSuccess(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(n.toString()),
    ));
  }

  void launchURL() async {
    launchUrl(
        Uri.parse(
            'https://wa.me/6282231353000?text=Saya%20Lupa%20Password%20aplikasi%20MyDianIstana%2C%20mohon%20dibantu%20untuk%20mereset%20password%0A%0ANama%3A%0ABlok%20%26%20Nomor%20Rumah%3A'),
        mode: LaunchMode.externalApplication);
  }
}
