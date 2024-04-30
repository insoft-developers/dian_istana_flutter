import 'package:dianistana/menu_screens/booking/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class Term extends StatefulWidget {
  const Term({Key? key}) : super(key: key);

  @override
  State<Term> createState() => _TermState();
}

class _TermState extends State<Term> {
  final BookingController _booking = Get.put(BookingController());

  @override
  void initState() {
    _booking.getTerm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Term & Conditions",
          style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Obx(
          () => _booking.settingLoad.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()))
              : ListView(
                  children: [
                    Obx(
                      () => Html(
                        data: _booking.settingList["term"].toString(),
                        defaultTextStyle: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 15),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
