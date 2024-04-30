import 'dart:convert';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/menu_screens/booking/resume.dart';
import 'package:flutter/material.dart';
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

  void bookingResume() async {
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
      Get.to(() => const ResumePage());
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
        print(unitList);
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
