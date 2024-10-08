import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/main_slider.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/controllers/dashboard_controller.dart';
import 'package:dianistana/controllers/login_controller.dart';
import 'package:dianistana/menu_screens/history/index.dart';
import 'package:dianistana/menu_screens/payment/index.dart';
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
    _dashboard.versionCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/white_bg.png",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.all(0),
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              Jarak(tinggi: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      "images/logo_line.png",
                      height: 30,
                    ),
                  ),
                ],
              ),
              Jarak(tinggi: 40),
              Container(
                margin: const EdgeInsets.only(left: 40),
                child: const Text(
                  "Welcome Home, ",
                  style: TextStyle(fontFamily: 'Rubik', fontSize: 12),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 40),
                child: Obx(
                  () => Text(
                    _dashboard.userName.value,
                    style: const TextStyle(fontFamily: 'RubikBold'),
                  ),
                ),
              ),
              Jarak(tinggi: 10),
              const SizedBox(height: 230, child: MainSlider()),
              Jarak(tinggi: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            _dashboard.bookingCheck();
                            // Get.to(() => const BookingPage());
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
                                      width: 2.0,
                                      color: const Color.fromARGB(
                                          96, 180, 176, 176))),
                              child: Column(
                                children: [
                                  Image.asset("images/booking.png",
                                      fit: BoxFit.cover, width: 50, height: 50),
                                  Jarak(tinggi: 12),
                                  const Center(
                                    child: Text(
                                      "BOOKINGS",
                                      style: TextStyle(
                                          fontFamily: 'Rubik', fontSize: 12),
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
                            Get.to(() => const TicketingPage());
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
                                      width: 2.0,
                                      color: const Color.fromARGB(
                                          96, 180, 176, 176))),
                              child: Column(
                                children: [
                                  Image.asset("images/tikets.png",
                                      fit: BoxFit.contain,
                                      width: 50,
                                      height: 50),
                                  Jarak(tinggi: 12),
                                  const Center(
                                    child: Text(
                                      "SERVICES",
                                      style: TextStyle(
                                          fontFamily: 'Rubik', fontSize: 12),
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          splashColor: Colors.amber,
                          child: Container(
                              height: 140,
                              width: 150,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color.fromARGB(
                                          96, 180, 176, 176))),
                              child: Column(
                                children: [
                                  Image.asset("images/payments.png",
                                      fit: BoxFit.contain,
                                      width: 50,
                                      height: 50),
                                  Jarak(tinggi: 12),
                                  const Center(
                                    child: Text(
                                      "PAYMENT",
                                      style: TextStyle(
                                          fontFamily: 'Rubik', fontSize: 12),
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
                            Get.to(() => const HistoryPage());
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
                                      width: 2.0,
                                      color: const Color.fromARGB(
                                          96, 180, 176, 176))),
                              child: Column(
                                children: [
                                  Image.asset("images/histori.png",
                                      fit: BoxFit.contain,
                                      width: 50,
                                      height: 50),
                                  Jarak(tinggi: 12),
                                  const Center(
                                    child: Text(
                                      "HISTORY",
                                      style: TextStyle(
                                          fontFamily: 'Rubik', fontSize: 12),
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          splashColor: Colors.amber,
                          child: Container(
                              height: 140,
                              width: 150,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color.fromARGB(
                                          96, 180, 176, 176))),
                              child: Column(
                                children: [
                                  Image.asset("images/profil.png",
                                      fit: BoxFit.contain,
                                      width: 50,
                                      height: 50),
                                  Jarak(tinggi: 12),
                                  const Center(
                                    child: Text(
                                      "PROFILE",
                                      style: TextStyle(
                                          fontFamily: 'Rubik', fontSize: 12),
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
                            Get.to(() => const UserData());
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
                                      width: 2.0,
                                      color: const Color.fromARGB(
                                          96, 180, 176, 176))),
                              child: Column(
                                children: [
                                  Image.asset("images/userdata.png",
                                      fit: BoxFit.contain,
                                      width: 50,
                                      height: 50),
                                  Jarak(tinggi: 12),
                                  const Center(
                                    child: Text(
                                      "USER DATA",
                                      style: TextStyle(
                                          fontFamily: 'Rubik', fontSize: 12),
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
              Jarak(tinggi: 50)
            ],
          ),
        ),
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
                fontFamily: 'Rubik',
              ))),
      onPressed: () {
        _login.logout();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Exit Application",
          style: TextStyle(
            fontFamily: 'RubikBold',
            color: Colors.green,
          )),
      content: const Text("Are you sure to exit from application...?",
          style: TextStyle(
            fontFamily: 'Rubik',
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
