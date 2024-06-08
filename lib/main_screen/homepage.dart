import 'dart:io';

import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/controllers/dashboard_controller.dart';
import 'package:dianistana/menu_screens/booking/index.dart';
import 'package:dianistana/menu_screens/dashboard/index.dart';
import 'package:dianistana/menu_screens/notif/index.dart';
import 'package:dianistana/menu_screens/payment/index.dart';
import 'package:dianistana/menu_screens/profile/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DashboardController _dashboard = Get.put(DashboardController());

  int _currentIndex = 2;
  final List<Widget> _children = [
    const PaymentPage(),
    const NotifPage(),
    const DashboardPage(),
    const BookingPage(),
    const ProfilePage()
  ];

  void onBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Application...?'),
            content: const Text('are you sure to exit the application...? '),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: Stack(
          children: [
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.asset(
                  "images/black_bg.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  height: 90,
                ),
              ),
            ),
            Container(
              // margin: const EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              color: Colors.transparent,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                backgroundColor: Colors.transparent,
                unselectedItemColor: Colors.grey,
                currentIndex: _currentIndex,
                onTap: (value) {
                  if (value == 3) {
                    _dashboard.bookingCheckHome().then((nilai) {
                      if (nilai) {
                        onBarTapped(value);
                      }
                    });
                  } else {
                    onBarTapped(value);
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("images/payments.png"),
                        size: 25,
                      ),
                      label: 'Payment'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 25,
                      ),
                      label: 'Notif'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        size: 30,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("images/booking.png"),
                        size: 25,
                      ),
                      label: 'Booking'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("images/profil.png"),
                        size: 25,
                      ),
                      label: 'Profile'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
