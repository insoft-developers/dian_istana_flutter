import 'package:cached_network_image/cached_network_image.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/menu_screens/ticketing/reply.dart';
import 'package:dianistana/menu_screens/ticketing/ticketing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketingDetail extends StatefulWidget {
  String number;
  String subject;
  TicketingDetail({Key? key, required this.number, required this.subject})
      : super(key: key);

  @override
  State<TicketingDetail> createState() => _TicketingDetailState();
}

class _TicketingDetailState extends State<TicketingDetail> {
  final TicketingController _ticketing = Get.put(TicketingController());

  @override
  void initState() {
    _ticketing.getDataDetail(widget.number);
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
        title: Text(
          widget.subject,
          style: const TextStyle(
              color: Colors.green, fontFamily: 'PoppinsBold', fontSize: 15),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          tooltip: 'Open New Ticket',
          onPressed: () {
            Get.to(() => Reply(number: widget.number))!
                .then((value) => _ticketing.getDataDetail(widget.number));
          },
          child: const Icon(Icons.reply, color: Colors.white, size: 28),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Obx(
          () => _ticketing.detailLoading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()))
              : ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2.0, color: Colors.red),
                          color: Colors.yellow),
                      child: const Text(
                          "Ticketing services will only respond during working hours: From 09:00 AM to 03:00 PM. We strive to provide the best service and thank you for your understanding.",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                    ),
                    Jarak(tinggi: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: _ticketing.detailData.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue.shade100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2.0,
                                                color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: CachedNetworkImage(
                                              imageUrl: _ticketing
                                                  .detailData[index]
                                                      ["profile_foto"]
                                                  .toString(),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Spasi(lebar: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _ticketing.detailData[index]
                                                    ["profile_name"]
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 15),
                                          ),
                                          Text(
                                            _ticketing.detailData[index]
                                                    ["waktu"]
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Html(
                                    data: _ticketing.detailData[index]
                                            ["message"]
                                        .toString(),
                                    onLinkTap: (url) async {
                                      if (await canLaunch(url)) {
                                        await launch(
                                          url,
                                        );
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    defaultTextStyle: const TextStyle(
                                        fontFamily: 'Poppins', fontSize: 14),
                                  ),
                                  Jarak(tinggi: 10),
                                  _ticketing.detailData[index]["document"] !=
                                          null
                                      ? Row(
                                          children: [
                                            const Icon(Icons.attach_file),
                                            GestureDetector(
                                              onTap: () {
                                                _ticketing.download(
                                                    _ticketing.detailData[index]
                                                            ['document']
                                                        .toString(),
                                                    Constant.TICKETING_URL +
                                                        _ticketing
                                                            .detailData[index]
                                                                ['document']
                                                            .toString());
                                              },
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    100,
                                                child: Text(
                                                  "attached file " +
                                                      _ticketing
                                                          .detailData[index]
                                                              ["document"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.blue[900],
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : const SizedBox(),
                                  Jarak(tinggi: 20)
                                ],
                              ));
                        }),
                  ],
                ),
        ),
      ),
    );
  }
}
