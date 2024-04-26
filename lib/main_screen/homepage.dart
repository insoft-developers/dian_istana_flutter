import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DashboardController _dashboard = Get.put(DashboardController());

  @override
  void initState() {
    _dashboard.getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(children: [
            Image.asset("images/top1.png",
                height: 90,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover),
            Positioned(
              top: 10,
              left: 10,
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
              "Semoga Anda tetap dalam keadaan sehat dan bersemangat",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
            ),
          ),
          Jarak(tinggi: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade100),
                      child: Image.asset("images/bookings.png",
                          fit: BoxFit.contain),
                    ),
                    Jarak(tinggi: 4),
                    const Text(
                      "Booking",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade100),
                      child: Image.asset("images/history.png",
                          fit: BoxFit.contain),
                    ),
                    Jarak(tinggi: 4),
                    const Text(
                      "History",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade100),
                      child:
                          Image.asset("images/tiket.png", fit: BoxFit.contain),
                    ),
                    Jarak(tinggi: 4),
                    const Text(
                      "Ticketing",
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
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade100),
                      child: Image.asset("images/payments.png",
                          fit: BoxFit.contain),
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
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade100),
                      child: Image.asset("images/userdata.png",
                          fit: BoxFit.contain),
                    ),
                    Jarak(tinggi: 4),
                    const Text(
                      "User Data",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade100),
                      child:
                          Image.asset("images/notif.png", fit: BoxFit.contain),
                    ),
                    Jarak(tinggi: 4),
                    const Text(
                      "Notif",
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
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade100),
                      child: Image.asset("images/profile.png",
                          fit: BoxFit.contain),
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
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade100),
                      child: Image.asset("images/password.png",
                          fit: BoxFit.contain),
                    ),
                    Jarak(tinggi: 4),
                    const Text(
                      "Change Pwd",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green.shade100),
                      child:
                          Image.asset("images/tiket.png", fit: BoxFit.contain),
                    ),
                    Jarak(tinggi: 4),
                    const Text(
                      "Ticketing",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
