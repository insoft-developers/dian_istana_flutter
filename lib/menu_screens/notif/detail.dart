import 'package:cached_network_image/cached_network_image.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifDetail extends StatefulWidget {
  Map<String, dynamic> dataList;
  NotifDetail({Key? key, required this.dataList}) : super(key: key);

  @override
  State<NotifDetail> createState() => _NotifDetailState();
}

class _NotifDetailState extends State<NotifDetail> {
  @override
  void initState() {
    print(widget.dataList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/white_bg.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Jarak(tinggi: 40),
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
              Jarak(tinggi: 30),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: const [
                      Text("NOTIFICATION DETAIL",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ListView(
                    children: [
                      Text(widget.dataList["title"],
                          style: const TextStyle(
                              fontFamily: 'RubikBold', fontSize: 22)),
                      Jarak(tinggi: 15),
                      widget.dataList["image"] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                  imageUrl: Constant.NOTIF_IMAGE +
                                      widget.dataList["image"].toString(),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width),
                            )
                          : const SizedBox(),
                      Jarak(tinggi: 20),
                      Text(widget.dataList["message"],
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                          )),
                      Jarak(tinggi: 20),
                      Text(
                          widget.dataList["admin_name"] +
                              ", " +
                              widget.dataList["waktu"],
                          style: const TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
