import 'package:dianistana/components/jarak.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Booking History",
          style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Obx(
          () => _history.loading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()))
              : ListView.builder(
                  itemCount: _history.historyList.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    Color warna = Colors.white;
                    if (_history.historyList[index]['payment_status'] ==
                        "PENDING") {
                      warna = Colors.orange.shade100;
                    } else if (_history.historyList[index]['payment_status'] ==
                        "PAID") {
                      warna = Colors.green.shade100;
                    } else if (_history.historyList[index]['payment_status'] ==
                        "CANCELLED") {
                      warna = Colors.red.shade100;
                    }

                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: warna),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Transaction Date",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  _utils.getOnlyDate(_history.historyList[index]
                                          ['created_at']
                                      .toString()),
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsBold', fontSize: 15)),
                            ],
                          ),
                          Jarak(tinggi: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("User",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  _history.historyList[index]['name']
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsBold', fontSize: 15)),
                            ],
                          ),
                          Jarak(tinggi: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Facility Name",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  _history.historyList[index]['name_unit']
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsBold', fontSize: 15)),
                            ],
                          ),
                          Jarak(tinggi: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Invoice",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  _history.historyList[index]['invoice']
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsBold', fontSize: 15)),
                            ],
                          ),
                          Jarak(tinggi: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Booking Date",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  _utils.getOnlyDate(_history.historyList[index]
                                          ['booking_date']
                                      .toString()),
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsBold', fontSize: 15)),
                            ],
                          ),
                          Jarak(tinggi: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Booking Time",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  _history.historyList[index]['start_time']
                                          .toString() +
                                      ":00 - " +
                                      _history.historyList[index]['finish_time']
                                          .toString() +
                                      ":00",
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsBold', fontSize: 15)),
                            ],
                          ),
                          Jarak(tinggi: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Quantity",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  _history.historyList[index]['quantity']
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsBold', fontSize: 15)),
                            ],
                          ),
                          Jarak(tinggi: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Price",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  _history.historyList[index]['total_price'] ==
                                          0
                                      ? "FREE"
                                      : "Rp. " +
                                          _utils.formatAmount(_history
                                              .historyList[index]['total_price']
                                              .toString()),
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsBold', fontSize: 15)),
                            ],
                          ),
                          Jarak(tinggi: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Payment Status",
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  _history.historyList[index]['payment_status']
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'PoppinsBold', fontSize: 15)),
                            ],
                          ),
                          Jarak(tinggi: 10),
                          _history.historyList[index]["payment_status"] ==
                                  "PAID"
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton.icon(
                                      onPressed: () {
                                        _history.printTicket(_history
                                            .historyList[index]["id"]
                                            .toString());
                                      },
                                      icon: const Icon(Icons.airplane_ticket),
                                      label: const Text("PRINT")),
                                )
                              : _history.historyList[index]["payment_status"] ==
                                      "PENDING"
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.orange),
                                          onPressed: () {
                                            _history.paymentProcess(_history
                                                .historyList[index]["id"]);
                                          },
                                          icon: const Icon(Icons.payment),
                                          label: const Text("PAY NOW")),
                                    )
                                  : const SizedBox()
                        ],
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
