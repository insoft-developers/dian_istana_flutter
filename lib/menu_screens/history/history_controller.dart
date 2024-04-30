import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/menu_screens/payment/pay_webview.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  var historyList = List.empty().obs;
  var loading = false.obs;

  void getHistoryList() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var res = await Network().getData('/history/' + userId.toString());
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        historyList.value = body['data'];
        print(historyList);
      }
    }
  }

  void printTicket(String id) {
    String url = Constant.PRINT_TICKET_URL + "/" + id;
    print(url);
    Get.to(() => PayWebview(paymentUrl: url));
  }

  void paymentProcess(int transId) async {
    var data = {"id": transId};
    var res = await Network().auth(data, '/payment_process');
    var body = jsonDecode(res.body);
    if (body['success']) {
      print(body);
      Get.to(
          () => PayWebview(paymentUrl: body['data']['paymentUrl'].toString()));
    }
  }
}
