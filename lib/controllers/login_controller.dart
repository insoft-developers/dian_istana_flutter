import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/main_screen/homepage.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var userData = <String, dynamic>{}.obs;
  var loading = false.obs;
  var isAuth = false.obs;

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
      Get.offAll(const HomePage());
    } else {
      showError(body['message'].toString());
      loading(false);
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
}
