import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/menu_screens/ticketing/download_progress.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class TicketingController extends GetxController {
  var ticketList = List.empty().obs;
  var loading = false.obs;
  var detailLoading = false.obs;
  var detailData = List.empty().obs;
  var departmentList = List.empty().obs;
  var defaultDepartmentValue = "".obs;
  var defaultPriorityValue = "".obs;
  var openLoading = false.obs;
  var uploadLoading = false.obs;

  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  String? _imagePath;
  String? get imagePath => _imagePath;
  final _picker = ImagePicker();

  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

  Future<void> resetPicker() async {
    _pickedFile = null;
    update();
  }

  Future<bool> upload(String ids) async {
    update();
    bool success = false;
    http.StreamedResponse response = await updateImage(_pickedFile, ids);

    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      success = true;

      _imagePath = message;
      openLoading(false);
    } else {}
    update();
    openLoading(false);
    showSuccess("File succesfully uploaded");
    // Get.back();
    return success;
  }

  Future<http.StreamedResponse> updateImage(
      PickedFile? data, String ids) async {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(Constant.TICKETING_UPLOAD_URL));

    if (GetPlatform.isMobile && data != null) {
      File _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    }

    Map<String, String> _fields = {};
    _fields.addAll(<String, String>{'ids': ids});
    request.fields.addAll(_fields);

    http.StreamedResponse response = await request.send();
    return response;
  }

  void changeSelectedDepartment(String value) {
    defaultDepartmentValue.value = value;
  }

  void changeSelectedPriority(String value) {
    defaultPriorityValue.value = value;
  }

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
    }
  }

  // void download(String namaFile, String downloadUrl) async {
  //   bool result = await _permissionRequest();
  //   if (result) {
  //     showDialog(
  //         context: Get.context!,
  //         builder: (dialogcontext) {
  //           return DownloadProgressDialog(
  //             namaFile: namaFile,
  //             downloadUrl: downloadUrl,
  //           );
  //         });
  //     print("PRINT " + namaFile);
  //     OpenFile.open('/storage/emulated/0/Download/dian_istana_' + namaFile);
  //   } else {
  //     print("No permission to read and write.");
  //   }
  // }

  static Future<bool> _permissionRequest() async {
    PermissionStatus result;
    result = await Permission.storage.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future getDepartmentData() async {
    var res = await Network().getData('/department');
    var body = jsonDecode(res.body);
    if (body['success']) {
      departmentList.value = body['data'];
      print(departmentList.value);
    }
  }

  List<DropdownMenuItem<String>> get dropdownDepartment {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(
      const DropdownMenuItem(
          child: Text(
            "Select Department",
            style: TextStyle(
                fontFamily: 'Rubik', fontSize: 14, color: Colors.grey),
          ),
          value: ""),
    );

    for (var i = 0; i < departmentList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
            child: SizedBox(
                width: 190,
                child: Text(departmentList[i]['category_name'].toString(),
                    overflow: TextOverflow.visible)),
            value: departmentList[i]['id'].toString()),
      );
    }
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownPriority {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(
      const DropdownMenuItem(
          child: Text(
            "Select Priority",
            style: TextStyle(
                fontFamily: 'Rubik', fontSize: 14, color: Colors.grey),
          ),
          value: ""),
    );

    menuItems.add(
      const DropdownMenuItem(
          child: SizedBox(
              width: 190, child: Text("Low", overflow: TextOverflow.visible)),
          value: "Low"),
    );
    menuItems.add(
      const DropdownMenuItem(
          child: SizedBox(
              width: 190,
              child: Text("Medium", overflow: TextOverflow.visible)),
          value: "Medium"),
    );
    menuItems.add(
      const DropdownMenuItem(
          child: SizedBox(
              width: 190, child: Text("High", overflow: TextOverflow.visible)),
          value: "High"),
    );
    menuItems.add(
      const DropdownMenuItem(
          child: SizedBox(
              width: 190,
              child: Text("Critical", overflow: TextOverflow.visible)),
          value: "Critical"),
    );

    return menuItems;
  }

  void openTicket(String subject, String message) async {
    openLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {
        "user_id": userId,
        "subject": subject,
        "department": defaultDepartmentValue.value,
        "priority": defaultPriorityValue.value,
        "message": message,
      };

      var res = await Network().auth(data, '/open');
      var body = jsonDecode(res.body);
      if (body['success']) {
        if (_pickedFile != null) {
          upload(body['id'].toString());
        } else {
          showSuccess(body['message'].toString());
          openLoading(false);
          Get.back();
        }
      } else {
        showError(body['message'].toString());
        openLoading(false);
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

  Future<bool> requestStoragePermissions() async {
    var storagePermissionIsGranted = false;

    final storageReq = await Permission.storage
        .request(); // required for android before 9 (SDK 28)
    log('requestStoragePermissions storageReq  ${storageReq.name} ${storageReq.isGranted}');
    storagePermissionIsGranted = storageReq.isGranted;
    if (!storagePermissionIsGranted) {
      final manageExternalStorageReq = await Permission.manageExternalStorage
          .request(); // required for android after 9 (SDK 28)
      log('requestStoragePermissions manageExternalStorageReq ${manageExternalStorageReq.name} ${manageExternalStorageReq.isGranted}');
      storagePermissionIsGranted = manageExternalStorageReq.isGranted;
    }

    final accessMediaLocationReq =
        await Permission.accessMediaLocation.request();
    log('requestStoragePermissions accessMediaLocationReq ${accessMediaLocationReq.name} ${accessMediaLocationReq.isGranted}');

    final mediaLibraryReq = await Permission.mediaLibrary.request();
    log('requestStoragePermissions mediaLibraryReq ${mediaLibraryReq.name} ${mediaLibraryReq.isGranted}');

    final microphoneReq = await Permission.microphone.request();
    log('requestStoragePermissions microphoneReq ${microphoneReq.name} ${microphoneReq.isGranted}');

    final cameraReq = await Permission.camera.request();
    log('requestStoragePermissions cameraReq ${cameraReq.name} ${cameraReq.isGranted}');

    final audioReq = true;
    final videosReq = true;
    final photosReq = true;

    var isGranted = storagePermissionIsGranted &&
        accessMediaLocationReq.isGranted &&
        mediaLibraryReq.isGranted &&
        microphoneReq.isGranted &&
        cameraReq.isGranted;

    return isGranted;
  }

  void launchURL(String url) async {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
