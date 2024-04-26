import 'package:dianistana/controllers/login_controller.dart';
import 'package:dianistana/main_screen/homepage.dart';
import 'package:dianistana/main_screen/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final LoginController _loginController = Get.put(LoginController());

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var user = localStorage.getString('user');
    if (token != null && user != null) {
      if (mounted) {
        _loginController.setLogin();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          _loginController.isAuth.value ? const HomePage() : const LoginPage()),
    );
  }
}
