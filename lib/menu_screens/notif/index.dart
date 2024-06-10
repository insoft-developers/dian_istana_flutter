import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/controllers/login_controller.dart';
import 'package:dianistana/menu_screens/notif/detail.dart';
import 'package:dianistana/menu_screens/notif/notif_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);
  static const route = '/announcement';

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  final NotifController _notif = Get.put(NotifController());
  final LoginController _logins = Get.put(LoginController());

  @override
  void initState() {
    _notif.getNotifData();
    _logins.notifNumber.value = 0;
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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Jarak(tinggi: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: const Text("POWERED BY",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 10)),
                  ),
                  Image.asset(
                    "images/logo_line.png",
                    height: 22,
                  ),
                ],
              ),
              Jarak(tinggi: 30),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/left.png",
                        height: 30,
                        width: 30,
                      ),
                      Spasi(lebar: 10),
                      const Text("NOTIFICATIONS",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Obx(
                      () => _notif.loading.value
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : ListView.builder(
                              itemCount: _notif.notifList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => NotifDetail(
                                        dataList: _notif.notifList[index]));
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.7),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              _notif.notifList[index]["title"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green)),
                                          Jarak(tinggi: 25),
                                          Text(
                                              _notif.notifList[index]
                                                      ["pesan_singkat"]
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13,
                                              )),
                                          Jarak(tinggi: 40),
                                          Text(
                                              "Sent By " +
                                                  _notif.notifList[index]
                                                          ["admin_name"]
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 13,
                                                  color: Colors.green)),
                                          Jarak(tinggi: 10),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                                _notif.notifList[index]["waktu"]
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                )),
                                          ),
                                        ],
                                      )),
                                );
                              }),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
