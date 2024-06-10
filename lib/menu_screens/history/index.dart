import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/controllers/utils_controller.dart';
import 'package:dianistana/menu_screens/history/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _history = Get.put(HistoryController());
  final UtilsController _utils = Get.put(UtilsController());

  @override
  void initState() {
    _history.getHistoryList();
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
                      const Text("BOOKING HISTORY",
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Obx(
                    () => _history.loading.value
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                                child: CircularProgressIndicator()))
                        : ListView.builder(
                            itemCount: _history.historyList.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              Color warna = Colors.white;
                              if (_history.historyList[index]
                                      ['payment_status'] ==
                                  "PENDING") {
                                warna = Colors.white;
                              } else if (_history.historyList[index]
                                      ['payment_status'] ==
                                  "PAID") {
                                warna = Colors.white;
                              } else if (_history.historyList[index]
                                      ['payment_status'] ==
                                  "CANCELLED") {
                                warna = Colors.red.shade50;
                              }

                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.circular(5),
                                    color: warna),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Transaction Date",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins')),
                                        Text(
                                            _utils.getOnlyDate(_history
                                                .historyList[index]
                                                    ['created_at']
                                                .toString()),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Jarak(tinggi: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("User",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins')),
                                        Text(
                                            _history.historyList[index]['name']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Jarak(tinggi: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Facility",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins')),
                                        Text(
                                            _history.historyList[index]
                                                    ['name_unit']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Jarak(tinggi: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Invoice",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins')),
                                        Text(
                                            _history.historyList[index]
                                                    ['invoice']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Jarak(tinggi: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Booking Date",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins')),
                                        Text(
                                            _utils.getOnlyDate(_history
                                                .historyList[index]
                                                    ['booking_date']
                                                .toString()),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Jarak(tinggi: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Booking Time",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins')),
                                        Text(
                                            _history.historyList[index]
                                                        ['start_time']
                                                    .toString() +
                                                ":00 - " +
                                                _history.historyList[index]
                                                        ['finish_time']
                                                    .toString() +
                                                ":00",
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Jarak(tinggi: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Quantity",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins')),
                                        Text(
                                            _history.historyList[index]
                                                    ['quantity']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Jarak(tinggi: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Total Price",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins')),
                                        Text(
                                            _history.historyList[index]
                                                        ['total_price'] ==
                                                    0
                                                ? "FREE"
                                                : "Rp. " +
                                                    _utils.formatAmount(_history
                                                        .historyList[index]
                                                            ['total_price']
                                                        .toString()),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Jarak(tinggi: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Payment Status",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins')),
                                        Text(
                                            _history.historyList[index]
                                                    ['payment_status']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Jarak(tinggi: 10),
                                    _history.historyList[index]
                                                ["payment_status"] ==
                                            "PAID"
                                        ? SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red[900]),
                                                onPressed: () {
                                                  _history.printTicket(_history
                                                      .historyList[index]["id"]
                                                      .toString());
                                                },
                                                child: const Text("PRINT")),
                                          )
                                        : _history.historyList[index]
                                                    ["payment_status"] ==
                                                "PENDING"
                                            ? SizedBox(
                                                width: 100,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Colors
                                                                .red[900]),
                                                    onPressed: () {
                                                      _history.paymentProcess(
                                                          _history.historyList[
                                                              index]["id"]);
                                                    },
                                                    child:
                                                        const Text("PAY NOW")),
                                              )
                                            : const SizedBox()
                                  ],
                                ),
                              );
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
