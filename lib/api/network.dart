import 'dart:convert';

import 'package:dianistana/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Network {
  // #DEVELOPMENT
  // final String _url = Constant.BASE_URL + 'public/api';

  // #LIVE SERVER
  final String _url = Constant.BASE_URL + 'api';

  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // token = jsonDecode(localStorage.getString('token')!);
    token = jsonDecode("13141099199191201201201");
  }

  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  authNoToken(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeader());
  }

  getData(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  getDataNoToken(apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeader(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  _setHeader() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
