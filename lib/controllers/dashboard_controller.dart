import 'dart:async';
import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/hb.dart';
import 'package:dianistana/main_screen/loginpage.dart';
import 'package:dianistana/menu_screens/booking/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {

  Timer? _logoutTimer;


  var userName = "".obs;
  var sliderList = List.empty().obs;
  var loading = false.obs;

  void startCheckLogoutLoop() {
  // jalankan setiap 5 detik
   _logoutTimer?.cancel();
    _logoutTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      checkLogout();
    });
  }


  void stopCheckLogoutLoop() {
  // kalau mau berhenti
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }



  void checkLogout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {"userid": userId};
      var res = await Network().auth3(data, '/check_logout');
      var body = jsonDecode(res.body);
      if (body['success']) {
        showError(body['message'].toString());
        Timer(const Duration(seconds: 5), () {
          logout();
        });
      }  else {
         print(body);
      } 
    } else {
      print('user not found');
    }
  }



  void versionCheck() async {
    var data = {"version": Constant.VERSION};
    var res = await Network().auth3(data, '/version_check');
    var body = jsonDecode(res.body);
    if (body['success']) {
    } else {
      showError(body['message'].toString());
      Timer(const Duration(seconds: 5), () {
        logout();
      });
    }
  }



  void bookingCheck() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {"user_id": userId};
      var res = await Network().auth3(data, '/booking_check');
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
      var res = await Network().auth3(data, '/booking_check');
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
    var res = await Network().getData3('/slider');
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
            color: Colors.white, fontFamily: 'Rubik', fontSize: 14),
      ),
    ));
  }

  void logout() async {
    stopCheckLogoutLoop();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      localStorage.remove('user');
      localStorage.remove('token');
      Get.offAll(() => const LoginPage());
    }
  }

  void getBirthday() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {"userid": userId};
      var res = await Network().auth3(data, '/get_birthday');
      var body = jsonDecode(res.body);
      if (body['success']) {
        Get.to(() => Hb(
              dataList: body['data'],
              umur: body['umur'].toString(),
            ));
        print(body);
      } else {
        print(body);
      }
    }
  }
}
