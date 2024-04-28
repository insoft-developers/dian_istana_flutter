import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/menu_screens/notif/detail.dart';
import 'package:dianistana/menu_screens/notif/notif_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  final NotifController _notif = Get.put(NotifController());

  @override
  void initState() {
    _notif.getNotifData();
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
          "Notifications",
          style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Obx(
            () => _notif.loading.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    itemCount: _notif.notifList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() =>
                              NotifDetail(dataList: _notif.notifList[index]));
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(3)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    _notif.notifList[index]["title"].toString(),
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepOrange)),
                                Jarak(tinggi: 5),
                                Text(
                                    _notif.notifList[index]["pesan_singkat"]
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                    )),
                                Jarak(tinggi: 10),
                                Text(
                                    "Sent By " +
                                        _notif.notifList[index]["admin_name"]
                                            .toString(),
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 13,
                                        color: Colors.blue)),
                                Jarak(tinggi: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                      _notif.notifList[index]["waktu"]
                                          .toString(),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontFamily: 'PoppinsBold',
                                          fontSize: 12,
                                          color: Colors.black)),
                                ),
                              ],
                            )),
                      );
                    }),
          )),
    );
  }
}
