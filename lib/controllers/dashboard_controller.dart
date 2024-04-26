import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  var userName = "".obs;
  var sliderList = List.empty().obs;
  var loading = false.obs;

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
}
