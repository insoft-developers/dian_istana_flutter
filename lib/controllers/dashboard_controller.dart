import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/menu_screens/booking/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  var userName = "".obs;
  var sliderList = List.empty().obs;
  var loading = false.obs;

  void bookingCheck() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {"user_id": userId};
      var res = await Network().auth(data, '/booking_check');
      var body = jsonDecode(res.body);
      if (body['success']) {
        Get.to(() => const BookingPage());
      } else {
        showError(body['message'].toString());
      }
    }
  }

  Future bookingCheckHome() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {"user_id": userId};
      var res = await Network().auth(data, '/booking_check');
      var body = jsonDecode(res.body);
      if (body['success']) {
        print(body);
        return true;
      } else {
        showError(body['message'].toString());
        return false;
      }
    }
  }

  void getUserName() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      userName.value = user['name'].toString();
    }
  }

  void getSliderData() async {
    var res = await Network().getData('/slider');
    var body = jsonDecode(res.body);
    if (body['success']) {
      sliderList.value = body['data'];
      print(sliderList);
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
}
