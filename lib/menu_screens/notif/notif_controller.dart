import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/menu_screens/notif/detail.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifController extends GetxController {
  var notifList = List.empty().obs;
  var loading = false.obs;
  var notifCount = 0.obs;

  void checkNotifCount() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {"userid": userId};
      var res = await Network().auth(data, '/check_notif_count');
      var body = jsonDecode(res.body);
      if (body['success']) {
        notifCount.value = body['data'];
        print(notifCount);
      }
    }
  }

  Future readNotif(String id, int indeks) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {"id": id, "userid": userId};
      var res = await Network().auth(data, '/read_notif');
      var body = jsonDecode(res.body);
      if (body['success']) {
        Get.to(() => NotifDetail(dataList: notifList[indeks]));
      }
    }
  }

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
      }
    }
  }
}
