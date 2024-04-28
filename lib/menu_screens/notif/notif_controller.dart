import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifController extends GetxController {
  var notifList = List.empty().obs;
  var loading = false.obs;

  void getNotifData() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var res = await Network().getData('/notif_list/' + userId.toString());
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        notifList.value = body['data'];
        print(notifList);
      }
    }
  }
}
