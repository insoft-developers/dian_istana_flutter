import 'dart:convert';
import 'dart:io';

import 'package:dianistana/api/network.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketingController extends GetxController {
  var ticketList = List.empty().obs;
  var loading = false.obs;
  var detailLoading = false.obs;
  var detailData = List.empty().obs;

  void getTicketingList() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var res = await Network().getData('/ticketing_list/' + userId.toString());
      var body = jsonDecode(res.body);
      if (body['success']) {
        ticketList.value = body['data'];
        loading(false);
        print(ticketList);
      }
    }
  }

  void getDataDetail(String number) async {
    detailLoading(true);
    var res = await Network().getData('/ticketing_detail/' + number);
    var body = jsonDecode(res.body);
    if (body['success']) {
      detailLoading(false);
      detailData.value = body['data'];
      print(detailData);
    }
  }

  Future<File> downloadFile(String url, String filename) async {
    var httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      final dir =
          await getTemporaryDirectory(); //(await getApplicationDocumentsDirectory()).path;
      File file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes);
      print('downloaded file path = ${file.path}');
      return file;
    } catch (error) {
      print('downloading error = $error');
      return File('');
    }
  }
}
