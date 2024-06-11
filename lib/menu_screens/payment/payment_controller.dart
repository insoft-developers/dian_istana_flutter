import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/menu_screens/payment/kwitansi_webview.dart';
import 'package:dianistana/menu_screens/payment/pay_webview.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentController extends GetxController {
  var paymentList = List.empty().obs;
  var loading = false.obs;
  var totalOutstanding = 0.obs;
  var payload = false.obs;

  void getPaymentData() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var res = await Network().getData('/payment_list/' + userId.toString());
      var body = jsonDecode(res.body);
      if (body['success']) {
        loading(false);
        paymentList.value = body['data'];
        totalOutstanding.value = body['total'];
        print(body);
      }
    }
  }

  void printKwitansi(String id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      String linkTo = Constant.BASE_URL +
          "api/kwitansi/" +
          id.toString() +
          "/" +
          userId.toString() +
          "?code=313fd1";
      print(linkTo);
      Get.to(() => KwitansiWebview(paymentUrl: linkTo));

      // final Uri url = Uri.parse(linkTo);
      // if (!await launchUrl(url)) {
      //   throw Exception("Error");
      // }
    }
  }

  void paymentPost(int paymentId) async {
    payload(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {'id': paymentId, 'user_id': userId};
      var res = await Network().auth(data, '/payment_post');
      var body = jsonDecode(res.body);
      if (body['success']) {
        payload(false);
        Get.to(() =>
                PayWebview(paymentUrl: body['data']['paymentUrl'].toString()))!
            .then((value) {
          getPaymentData();
        });
      } else {
        showError(body['message'].toString());
        payload(false);
      }
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

  void showSuccess(String n) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(n.toString()),
    ));
  }
}
