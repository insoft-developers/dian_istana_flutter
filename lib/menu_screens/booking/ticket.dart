import 'dart:io';

import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/controllers/utils_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends StatefulWidget {
  Map<String, dynamic> dataList;
  TicketPage({Key? key, required this.dataList}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final UtilsController _utils = Get.put(UtilsController());

  @override
  void initState() {
    super.initState();
    print(widget.dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("images/white_bg.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Jarak(tinggi: 50),
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
                    margin: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Spasi(lebar: 10),
                        const Text("BOOKING TICKET",
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
                    child: Stack(
                      children: [
                        Image.asset("images/cip.png",
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill),
                        Positioned(
                          left: 40,
                          top: 40,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("BOOKING TICKET",
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 15,
                                        color: Colors.black54)),
                                Jarak(tinggi: 0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("Booking Code",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black45,
                                            fontSize: 14)),
                                    Text(" : " + widget.dataList['invoice'],
                                        style: const TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black54,
                                            fontSize: 14))
                                  ],
                                ),
                                Jarak(tinggi: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("Name",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black45,
                                            fontSize: 14)),
                                    Spasi(lebar: 40),
                                    const Text("Status",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black45,
                                            fontSize: 14)),
                                    Spasi(lebar: 30),
                                    const Text("Booking Date",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black45,
                                            fontSize: 14)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                          widget.dataList['name'].toString() +
                                              ' - ' +
                                              widget.dataList['blok']
                                                  .toString() +
                                              '/' +
                                              widget.dataList['nomor_rumah']
                                                  .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'RubikBold',
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                    Spasi(lebar: 40),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                          widget.dataList['level'].toString(),
                                          style: const TextStyle(
                                              fontFamily: 'RubikBold',
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                    Spasi(lebar: 30),
                                    Text(
                                        _utils.getOnlyDate(widget
                                            .dataList['booking_date']
                                            .toString()),
                                        style: const TextStyle(
                                            fontFamily: 'RubikBold',
                                            color: Colors.black54,
                                            fontSize: 14)),
                                  ],
                                ),
                                Jarak(tinggi: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("Start",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black45,
                                            fontSize: 14)),
                                    Spasi(lebar: 40),
                                    const Text("Finish",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black45,
                                            fontSize: 14)),
                                    Spasi(lebar: 30),
                                    const Text("Number of User",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black45,
                                            fontSize: 14)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                          widget.dataList['start_time']
                                                  .toString() +
                                              ":00",
                                          style: const TextStyle(
                                              fontFamily: 'RubikBold',
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                    Spasi(lebar: 30),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                          widget.dataList['finish_time']
                                                  .toString() +
                                              ":00",
                                          style: const TextStyle(
                                              fontFamily: 'RubikBold',
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                    Spasi(lebar: 30),
                                    Text(widget.dataList['quantity'].toString(),
                                        style: const TextStyle(
                                            fontFamily: 'RubikBold',
                                            color: Colors.black54,
                                            fontSize: 14)),
                                  ],
                                ),
                                Jarak(tinggi: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text("Price",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black45,
                                            fontSize: 14)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                          widget.dataList['final_price'] == null
                                              ? "Free"
                                              : _utils.formatAmount(widget
                                                  .dataList['final_price']
                                                  .toString()),
                                          style: const TextStyle(
                                              fontFamily: 'RubikBold',
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                                Jarak(tinggi: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        widget.dataList['name_unit'].toString(),
                                        style: const TextStyle(
                                            fontFamily: 'RubikBold',
                                            color: Colors.black45,
                                            fontSize: 14)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                          widget.dataList['package_name']
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Rubik',
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                    QrImage(
                                        data: widget.dataList['invoice']
                                            .toString(),
                                        size: 100,
                                        // You can include embeddedImageStyle Property if you
                                        //wanna embed an image from your Asset folder
                                        embeddedImageStyle:
                                            QrEmbeddedImageStyle(
                                                size: const Size(
                                          80,
                                          80,
                                        )))
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
            top: 400,
            left: 100,
            child:
                Image.asset("images/bayar.png", width: 100, fit: BoxFit.cover))
      ],
    );
  }
}
