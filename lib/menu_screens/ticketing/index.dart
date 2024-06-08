import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/controllers/utils_controller.dart';
import 'package:dianistana/menu_screens/ticketing/add_ticket.dart';
import 'package:dianistana/menu_screens/ticketing/detail.dart';
import 'package:dianistana/menu_screens/ticketing/ticketing_controller.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TicketingPage extends StatefulWidget {
  const TicketingPage({Key? key}) : super(key: key);

  @override
  State<TicketingPage> createState() => _TicketingPageState();
}

class _TicketingPageState extends State<TicketingPage> {
  final TicketingController _ticket = Get.put(TicketingController());
  final UtilsController _utils = Get.put(UtilsController());

  @override
  void initState() {
    _ticket.getTicketingList();
    // _ticket.requestStoragePermissions();
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
          floatingActionButton: Container(
            margin: const EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
              tooltip: 'Open New Ticket',
              onPressed: () {
                Get.to(() => const AddTicket())!
                    .then((value) => _ticket.getTicketingList());
              },
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ),
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
              Jarak(tinggi: 20),
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
                      const Text("TICKETING",
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
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 0, bottom: 20),
                  child: Obx(
                    () => _ticket.loading.value
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                                child: CircularProgressIndicator()))
                        : ListView.builder(
                            itemCount: _ticket.ticketList.length,
                            itemBuilder: (context, index) {
                              Color warna = Colors.white;
                              if (_ticket.ticketList[index]['status'] == 0) {
                                warna = Colors.orange;
                              } else if (_ticket.ticketList[index]['status'] ==
                                  1) {
                                warna = Colors.green;
                              } else if (_ticket.ticketList[index]['status'] ==
                                  2) {
                                warna = Colors.red;
                              } else if (_ticket.ticketList[index]['status'] ==
                                  3) {
                                warna = Colors.grey;
                              }

                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 15),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1.0, color: Colors.black54),
                                      color: Colors.white.withOpacity(0.4)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              _ticket.ticketList[index]
                                                      ["ticket_number"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                          Text(
                                              _ticket.ticketList[index]
                                                      ["category"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blue,
                                                  fontSize: 14)),
                                        ],
                                      ),
                                      Jarak(tinggi: 5),
                                      Text(
                                          "( " +
                                              _ticket.ticketList[index]
                                                      ["priority"]
                                                  .toString() +
                                              " ) - " +
                                              _ticket.ticketList[index]
                                                      ["subject"]
                                                  .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                      Html(
                                        data: "Description : " +
                                            _ticket.ticketList[index]["pesan"]
                                                .toString(),
                                        defaultTextStyle: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14),
                                      ),
                                      Jarak(tinggi: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              _utils.getOnlyDate(_ticket
                                                  .ticketList[index]
                                                      ["created_at"]
                                                  .toString()),
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                          Text(
                                              _utils.getOnlyDate(_ticket
                                                  .ticketList[index]
                                                      ["updated_at"]
                                                  .toString()),
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  fontSize: 14)),
                                        ],
                                      ),
                                      Jarak(tinggi: 15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: warna),
                                            onPressed: () {
                                              Get.to(() => TicketingDetail(
                                                    number: _ticket
                                                        .ticketList[index]
                                                            ['ticket_number']
                                                        .toString(),
                                                    subject: _ticket
                                                        .ticketList[index]
                                                            ['subject']
                                                        .toString(),
                                                  ));
                                            },
                                            child: Text(_ticket
                                                .ticketList[index]["stat"]
                                                .toString())),
                                      )
                                    ],
                                  ));
                            }),
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
