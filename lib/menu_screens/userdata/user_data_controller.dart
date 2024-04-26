import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataController extends GetxController {
  var userData = <String, dynamic>{}.obs;
  var loading = false.obs;

  void getUserData() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var res = await Network().getData('/user_data/$userId');
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        userData.value = body['data'];
        print(userData);
      }
    }
  }
}
