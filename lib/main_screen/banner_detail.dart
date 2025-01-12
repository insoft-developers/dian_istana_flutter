import 'package:cached_network_image/cached_network_image.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/constant.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class BannerDetail extends StatefulWidget {
  Map<String, dynamic> dataList;
  BannerDetail({Key? key, required this.dataList}) : super(key: key);

  @override
  State<BannerDetail> createState() => _BannerDetailState();
}

class _BannerDetailState extends State<BannerDetail> {
  @override
  void initState() {
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
                      Text("BANNER DETAIL",
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
                                imageUrl: Constant.SLIDER_IMAGE +
                                    widget.dataList["image"].toString(),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                              ),
                            )
                          : const SizedBox(),
                      Jarak(tinggi: 20),
                      Html(
                        data: widget.dataList["content"],
                        defaultTextStyle: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 15,
                        ),
                      ),
                      Jarak(tinggi: 20),
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
