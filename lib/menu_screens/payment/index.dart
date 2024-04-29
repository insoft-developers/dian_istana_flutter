import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/controllers/utils_controller.dart';
import 'package:dianistana/menu_screens/payment/pay_webview.dart';
import 'package:dianistana/menu_screens/payment/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentController _payment = Get.put(PaymentController());
  final UtilsController _utils = Get.put(UtilsController());

  @override
  void initState() {
    _payment.getPaymentData();
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
          "Payment & Bills",
          style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    const Text("Outstanding Bills",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: Colors.white)),
                    Jarak(tinggi: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.payments,
                            size: 35, color: Colors.white),
                        Spasi(lebar: 10),
                        Obx(
                          () => Text(
                              "Rp. " +
                                  _utils.formatAmount(_payment
                                      .totalOutstanding.value
                                      .toString()),
                              style: const TextStyle(
                                  fontFamily: 'PoppinsBold',
                                  fontSize: 28,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                )),
            Obx(
              () => _payment.loading.value
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      child: const Center(child: CircularProgressIndicator()))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: _payment.paymentList.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 6),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: _payment.paymentList[index]
                                              ["status"] ==
                                          "PAID"
                                      ? Border.all(
                                          width: 1.0, color: Colors.green)
                                      : Border.all(
                                          width: 1.0, color: Colors.pink),
                                  color: _payment.paymentList[index]
                                              ["status"] ==
                                          "PAID"
                                      ? Colors.green.shade100.withOpacity(0.4)
                                      : Colors.red.shade100.withOpacity(0.4)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      _payment.paymentList[index]
                                              ["payment_name"]
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: 'PoppinsBold',
                                          fontSize: 15)),
                                  Text(
                                      _payment.paymentList[index]
                                              ["payment_desc"]
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: Colors.blue)),
                                  Jarak(tinggi: 2),
                                  Text(
                                      "Due Date " +
                                          _payment.paymentList[index]
                                                  ["due_date"]
                                              .toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Poppins', fontSize: 14)),
                                  Text(
                                      _payment.paymentList[index]["bill_to"]
                                              .toString() +
                                          " - ( " +
                                          _payment.paymentList[index]["type"]
                                              .toString() +
                                          " )",
                                      style: const TextStyle(
                                          fontFamily: 'Poppins', fontSize: 14)),
                                  Jarak(tinggi: 5),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                        "Rp. " +
                                            _utils.formatAmount(_payment
                                                .paymentList[index]
                                                    ["payment_amount"]
                                                .toString()),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Jarak(tinggi: 10),
                                  Obx(
                                    () => _payment.paymentList[index]
                                                ["status"] ==
                                            'PAID'
                                        ? Center(
                                            child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.green),
                                                onPressed: () {
                                                  _payment.printKwitansi(
                                                      _payment
                                                          .paymentList[index]
                                                              ['id']
                                                          .toString());
                                                },
                                                icon: const Icon(Icons.print),
                                                label: const Text("Print")),
                                          )
                                        : Center(
                                            child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.orange),
                                                onPressed: () {
                                                  _payment.paymentPost(_payment
                                                          .paymentList[index]
                                                      ["id"]);
                                                },
                                                icon: const Icon(
                                                  Icons.attach_money,
                                                ),
                                                label: const Text("Pay Now")),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => _payment.paymentList[index]["status"] ==
                                      "PAID"
                                  ? const Positioned(
                                      top: 40,
                                      right: 10,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ))
                                  : const SizedBox(),
                            ),
                          ],
                        );
                      }),
            ),
            Jarak(tinggi: 30)
          ],
        ),
      ),
    );
  }
}
