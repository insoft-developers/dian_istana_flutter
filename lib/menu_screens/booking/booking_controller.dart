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
  var unitKategori = "".obs;
  var unitId = "".obs;
  var settingList = <String, dynamic>{}.obs;
  var settingLoad = false.obs;
  var transactionLoading = false.obs;
  var js6 = 0.obs;
  var js7 = 0.obs;
  var js8 = 0.obs;
  var js9 = 0.obs;
  var js10 = 0.obs;
  var js11 = 0.obs;
  var js12 = 0.obs;
  var js13 = 0.obs;
  var js14 = 0.obs;
  var js15 = 0.obs;
  var js16 = 0.obs;
  var js17 = 0.obs;
  var js18 = 0.obs;
  var js19 = 0.obs;
  var js20 = 0.obs;
  var jam6 = 0.obs;
  var jam7 = 0.obs;
  var jam8 = 0.obs;
  var jam9 = 0.obs;
  var jam10 = 0.obs;
  var jam11 = 0.obs;
  var jam12 = 0.obs;
  var jam13 = 0.obs;
  var jam14 = 0.obs;
  var jam15 = 0.obs;
  var jam16 = 0.obs;
  var jam17 = 0.obs;
  var jam18 = 0.obs;
  var jam19 = 0.obs;
  var jam20 = 0.obs;
  var showHourLoading = false.obs;
  var off_finish = 0.obs;

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
      "package_name": packageName.value,
      "level": userLevel.value,
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
      showHourLoading(true);
      selectedDate.value = "";
      var data = {"selected_date": value, "selected_unit": unitId.value};
      var res = await Network().auth(data, '/booking_invoice');
      var body = jsonDecode(res.body);
      if (body['success']) {
        selectedDate.value = value;
        selectedHour.value = "";
        selectedFinish.value = "";
        invoice.value = body['data'];
        js6.value = body['js6'];
        js7.value = body['js7'];
        js8.value = body['js8'];
        js9.value = body['js9'];
        js10.value = body['js10'];
        js11.value = body['js11'];
        js12.value = body['js12'];
        js13.value = body['js13'];
        js14.value = body['js14'];
        js15.value = body['js15'];
        js16.value = body['js16'];
        js17.value = body['js17'];
        js18.value = body['js18'];
        js19.value = body['js19'];
        js20.value = body['js20'];
        jam6.value = body['jam6'];
        jam7.value = body['jam7'];
        jam8.value = body['jam8'];
        jam9.value = body['jam9'];
        jam10.value = body['jam10'];
        jam11.value = body['jam11'];
        jam12.value = body['jam12'];
        jam13.value = body['jam13'];
        jam14.value = body['jam14'];
        jam15.value = body['jam15'];
        jam16.value = body['jam16'];
        jam17.value = body['jam17'];
        jam18.value = body['jam18'];
        jam19.value = body['jam19'];
        jam20.value = body['jam20'];
        print(unitKategori);
        showHourLoading(false);
      }
    }
  }

  void setSelectedHour(String jam) {
    selectedHour.value = jam;
    selectedFinish.value = "";
    checkMiddle(jam);
  }

  void checkMiddle(String jam) async {
    var data = {
      "start": jam,
      "booking_date": selectedDate.value,
      "unit_id": unitId.value,
      "quantity": quantity.value
    };
    var res = await Network().auth(data, '/check_middle');
    var body = jsonDecode(res.body);
    if (body['success']) {
      if (body['data'] == 1) {
        off_finish.value = body['finish'];
      } else {
        off_finish.value = 0;
      }

      print(off_finish);
    }
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
