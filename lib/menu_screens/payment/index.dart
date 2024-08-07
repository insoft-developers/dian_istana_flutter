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
                  margin: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Spasi(lebar: 10),
                      const Text("PAYMENT & BILLS",
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ListView(
                    children: [
                      Obx(
                        () => _payment.loading.value
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 300,
                                child: const Center(
                                    child: CircularProgressIndicator()))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: _payment.paymentList.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 15),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: _payment.paymentList[index]
                                                        ["status"] ==
                                                    "PAID"
                                                ? Border.all(
                                                    width: 1.0,
                                                    color: Colors.black54)
                                                : Border.all(
                                                    width: 1.0,
                                                    color: Colors.black54),
                                            color: _payment.paymentList[index]
                                                        ["status"] ==
                                                    "PAID"
                                                ? Colors.green.shade50
                                                    .withOpacity(0.4)
                                                : Colors.white
                                                    .withOpacity(0.4)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                _payment.paymentList[index]
                                                        ["payment_name"]
                                                    .toString()
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontFamily: 'RubikBold',
                                                    color: Colors.black54,
                                                    fontSize: 15)),
                                            Text(
                                                _payment.paymentList[index]
                                                        ["payment_desc"]
                                                    .toString()
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  fontFamily: 'Rubik',
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                )),
                                            Jarak(tinggi: 5),
                                            Jarak(tinggi: 25),
                                            Text(
                                                _payment.paymentList[index]
                                                            ['status'] ==
                                                        "PAID"
                                                    ? "PAID BILLS"
                                                    : "OUTSTANDING BILLS",
                                                style: const TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 14,
                                                )),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                  "Rp. " +
                                                      _utils.formatAmount(_payment
                                                          .paymentList[index]
                                                              ["payment_amount"]
                                                          .toString()),
                                                  style: const TextStyle(
                                                      fontFamily: 'Rubik',
                                                      color: Colors.black54,
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                            ),
                                            Jarak(tinggi: 25),
                                            Text(
                                                _payment.paymentList[index]
                                                            ['payment_type'] ==
                                                        1
                                                    ? "Due Date " +
                                                        _payment
                                                            .paymentList[index]
                                                                ["due_date"]
                                                            .toString()
                                                    : "*If there's a discrepancy in the amount, please contact admin via Ticketing.*",
                                                style: const TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 12,
                                                )),
                                            Jarak(tinggi: 10),
                                            Obx(
                                              () => _payment.paymentList[index]
                                                          ["status"] ==
                                                      'PAID'
                                                  ? ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Colors
                                                                  .black54),
                                                      onPressed: () {
                                                        _payment.printKwitansi(
                                                            _payment
                                                                .paymentList[
                                                                    index]['id']
                                                                .toString());
                                                      },
                                                      child:
                                                          const Text("Print"))
                                                  : ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Colors
                                                                  .red[900]),
                                                      onPressed: () {
                                                        _payment.paymentPost(
                                                            _payment.paymentList[
                                                                index]["id"]);
                                                      },
                                                      child: const Text(
                                                          "Pay Now")),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () => _payment.paymentList[index]
                                                    ["status"] ==
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
