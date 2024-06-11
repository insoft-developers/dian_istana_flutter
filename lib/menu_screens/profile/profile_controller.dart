import 'dart:convert';
import 'dart:io';

import 'package:dianistana/api/network.dart';
import 'package:dianistana/constant.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var userData = <String, dynamic>{}.obs;
  var loading = false.obs;
  var genderDefaultValue = "".obs;
  var updateLoading = false.obs;
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
      loading(false);
    } else {}
    update();
    updateLoading(false);
    showSuccess("profile image succesfully uploaded");
    return success;
  }

  Future<http.StreamedResponse> updateImage(
      PickedFile? data, String ids) async {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(Constant.UPLOAD_URL));

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

  void changeSelectedGender(String value) {
    genderDefaultValue.value = value;
  }

  Future getUserData() async {
    loading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var res = await Network().getData('/user_data/' + userId.toString());
      var body = jsonDecode(res.body);
      if (body['success']) {
        userData.value = body['data'];
        loading(false);
        return true;
      } else {
        return false;
      }
    }
  }

  List<DropdownMenuItem<String>> get dropdownGender {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(
      const DropdownMenuItem(
          child: Text(
            "Select Gender",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 15, color: Colors.grey),
          ),
          value: ""),
    );
    menuItems.add(
      const DropdownMenuItem(
          child: SizedBox(
              width: 180,
              child: Text("Laki-Laki", overflow: TextOverflow.ellipsis)),
          value: "Laki-laki"),
    );
    menuItems.add(
      const DropdownMenuItem(
          child: SizedBox(
              width: 180,
              child: Text("Perempuan", overflow: TextOverflow.ellipsis)),
          value: "Perempuan"),
    );

    return menuItems;
  }

  void profileUpdate(String email, String phone, String emergency, String pdam,
      String pln) async {
    updateLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);
    if (user != null) {
      var userId = user['id'];
      var data = {
        "id": userId,
        "email": email,
        "whatsapp_number": phone,
        "jenis_kelamin": genderDefaultValue.value,
        "whatsapp_emergency": emergency,
        "id_pelanggan_pdam": pdam,
        "nomor_meter_pln": pln
      };
      var res = await Network().auth(data, '/profile_update');
      var body = jsonDecode(res.body);
      if (body['success']) {
        if (_pickedFile != null) {
          upload(userId.toString());
        } else {
          showSuccess(body['message'].toString());
          updateLoading(false);
        }
      } else {
        showError(body['message'].toString());
        updateLoading(false);
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
