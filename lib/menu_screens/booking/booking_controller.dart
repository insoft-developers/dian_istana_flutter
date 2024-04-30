import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/menu_screens/booking/resume.dart';
import 'package:dianistana/menu_screens/history/index.dart';
import 'package:dianistana/menu_screens/payment/pay_webview.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingController extends GetxController {
  var loading = false.obs;
  var unitList = List.empty().obs;
  var userLevel = "".obs;
  var selectedHour = "".obs;
  var selectedFinish = "".obs;
  var selectedDate = "".obs;
  var resumeLoading = false.obs;
  var invoice = "".obs;
  var quantity = 0.obs;
  var totalPrice = 0.obs;
  var selectedPackage = "".obs;
  var packageName = "".obs;
  var unitId = "".obs;
  var settingList = <String, dynamic>{}.obs;
  var settingLoad = false.obs;
  var transactionLoading = false.obs;

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

  void sendTransaction() async {
    transactionLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {
        "business_unit_id": unitId.value,
        "invoice": invoice.value,
        "start_time": selectedHour.value,
        "finish_time": selectedFinish.value,
        "quantity": quantity.value,
        "total_price": totalPrice.value,
        "booking_date": selectedDate.value,
        "package_id": selectedPackage.value,
        "package_name": packageName.value,
        "user_id": userId,
        "level": userLevel.value
      };
      var res = await Network().auth(data, '/transaction');
      var body = jsonDecode(res.body);
      if (body['success']) {
        print(body);
        transactionLoading(false);
        if (body['total_price'] > 0) {
          paymentProcess(body['id']);
        } else {
          Get.off(() => const HistoryPage());
        }
      } else {
        showError(body['message'].toString());
        transactionLoading(false);
      }
    }
  }

  void getTerm() async {
    settingLoad(true);
    var res = await Network().getData('/term');
    var body = jsonDecode(res.body);
    if (body['success']) {
      settingLoad(false);
      settingList.value = body['data'];
    }
  }

  void bookingResume(dataList) async {
    resumeLoading(true);
    var data = {
      "business_unit_id": unitId.value,
      "invoice": invoice.value,
      "start_time": selectedHour.value,
      "finish_time": selectedFinish.value,
      "quantity": quantity.value,
      "total_price": totalPrice.value,
      "booking_date": selectedDate.value,
      "package_id": selectedPackage.value,
      "package_name": packageName.value
    };

    var res = await Network().auth(data, '/booking_resume');
    var body = jsonDecode(res.body);
    if (body['success']) {
      Get.to(() => ResumePage(
            dataList: dataList,
          ));
      resumeLoading(false);
    } else {
      showError(body['message'].toString());
      resumeLoading(false);
    }
  }

  void selectBookingDate(String value) async {
    if (value.isEmpty) {
      showError("Please Select Date First...");
    } else {
      var res = await Network().getData('/booking_invoice');
      var body = jsonDecode(res.body);
      if (body['success']) {
        selectedDate.value = value;
        selectedHour.value = "";
        selectedFinish.value = "";
        invoice.value = body['data'];
      }
    }
  }

  void setSelectedHour(String jam) {
    selectedHour.value = jam;
    selectedFinish.value = "";
  }

  void setSelectedFinish(String jam) {
    selectedFinish.value = jam;
    if (selectedHour.value.isNotEmpty) {
      int awal = int.parse(selectedHour.value);
      int akhir = int.parse(jam);
      int selisih = akhir - awal;
      quantity.value = selisih;
      countTotalPrice(selisih, jam);
    }
  }

  void countTotalPrice(int selisih, String jamSelesai) async {
    var data = {
      "awal": selectedHour.value,
      "akhir": jamSelesai,
      "quantity": selisih,
      "booking_date": selectedDate.value,
      "level": userLevel.value,
      "unit_id": unitId.value
    };

    var res = await Network().auth(data, '/count_booking_price');
    var body = jsonDecode(res.body);
    if (body['success']) {
      totalPrice.value = body['data'];
    }
  }

  void getUnitData() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      userLevel.value = user['level'].toString();
      var res = await Network().getData('/booking_list');
      var body = jsonDecode(res.body);
      if (body['success']) {
        unitList.value = body['data'];
        loading(false);
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
