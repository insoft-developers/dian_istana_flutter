import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/main_screen/homepage.dart';
import 'package:dianistana/menu_screens/dashboard/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController extends GetxController {
  var loading = false.obs;

  void changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var userName = user['username'];
      var data = {
        "id": userId,
        "username": userName,
        "old_password": oldPassword,
        "password": newPassword,
        "password_confirmation": confirmPassword
      };
      var res = await Network().auth(data, '/password_update');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        showSuccess(body['message'].toString());
        Get.off(const HomePage());
      } else {
        loading(false);
        showError(body['message'].toString());
      }
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
