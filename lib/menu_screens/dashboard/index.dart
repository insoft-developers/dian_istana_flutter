import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/main_slider.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/controllers/dashboard_controller.dart';
import 'package:dianistana/controllers/login_controller.dart';
import 'package:dianistana/menu_screens/booking/index.dart';
import 'package:dianistana/menu_screens/change_password/index.dart';
import 'package:dianistana/menu_screens/history/index.dart';
import 'package:dianistana/menu_screens/notif/index.dart';
import 'package:dianistana/menu_screens/payment/index.dart';
import 'package:dianistana/menu_screens/payment/pay_webview.dart';
import 'package:dianistana/menu_screens/profile/index.dart';
import 'package:dianistana/menu_screens/ticketing/index.dart';
import 'package:dianistana/menu_screens/userdata/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardController _dashboard = Get.put(DashboardController());
  final LoginController _login = Get.put(LoginController());

  @override
  void initState() {
    _dashboard.getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        Stack(children: [
          Image.asset("images/top1.png",
              height: 90,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    border: Border.all(width: 3.0, color: Colors.green),
                    borderRadius: BorderRadius.circular(30)),
                child: Image.asset(
                  "images/logo.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              top: 20,
              right: 15,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.4)),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 30,
                ),
              )),
          Obx(
            () => _login.notifNumber.value > 0
                ? Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red,
                      ),
                      child: Obx(
                        () => Text(_login.notifNumber.value.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ))
                : const SizedBox(),
          )
        ]),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Obx(
            () => Text(
              "Hi, ${_dashboard.userName.value}",
              style: const TextStyle(fontFamily: 'PoppinsBold'),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Welcome to MyDianIstana, \nmay goodness, health, and prosperity \nalways be with you",
            style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
          ),
        ),
        Jarak(tinggi: 40),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      _dashboard.bookingCheck();
                    },
                    splashColor: Colors.amber,
                    child: Container(
                        height: 140,
                        width: 150,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color.fromARGB(96, 180, 176, 176))),
                        child: Column(
                          children: [
                            Image.asset("images/booking.png",
                                fit: BoxFit.cover, width: 50, height: 50),
                            Jarak(tinggi: 12),
                            const Center(
                              child: Text(
                                "BOOKING",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 12),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      _dashboard.bookingCheck();
                    },
                    splashColor: Colors.amber,
                    child: Container(
                        height: 140,
                        width: 150,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(96, 180, 176, 176))),
                        child: Column(
                          children: [
                            Image.asset("images/tikets.png",
                                fit: BoxFit.contain, width: 50, height: 50),
                            Jarak(tinggi: 12),
                            const Center(
                              child: Text(
                                "TICKETING",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 12),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        Jarak(tinggi: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Get.to(() => const PaymentPage());
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade300.withOpacity(0.2)),
                      child: Image.asset("images/payments.png",
                          fit: BoxFit.contain),
                    ),
                  ),
                  Jarak(tinggi: 4),
                  const Text(
                    "Payment",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Get.to(() => const HistoryPage());
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade300.withOpacity(0.2)),
                      child: Image.asset("images/histori.png",
                          fit: BoxFit.contain),
                    ),
                  ),
                  Jarak(tinggi: 4),
                  const Text(
                    "History",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  )
                ],
              ),
            ],
          ),
        ),
        Jarak(tinggi: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Get.to(() => const ProfilePage());
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade300.withOpacity(0.2)),
                      child:
                          Image.asset("images/profil.png", fit: BoxFit.contain),
                    ),
                  ),
                  Jarak(tinggi: 4),
                  const Text(
                    "Profile",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Get.to(() => const UserData());
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade300.withOpacity(0.2)),
                      child: Image.asset("images/userdata.png",
                          fit: BoxFit.contain),
                    ),
                  ),
                  Jarak(tinggi: 4),
                  const Text(
                    "User Data",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  )
                ],
              ),
            ],
          ),
        ),
        Jarak(tinggi: 50),
        const SizedBox(height: 230, child: MainSlider()),
        Jarak(tinggi: 50)
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    LoginController _login = Get.put(LoginController());
    Widget cancelButton = FlatButton(
      child: const Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = FlatButton(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.green,
          ),
          child: const Text("Yes",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ))),
      onPressed: () {
        _login.logout();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Exit Application",
          style: TextStyle(
            fontFamily: 'PoppinsBold',
            color: Colors.green,
          )),
      content: const Text("Are you sure to exit from application...?",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
          )),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
