import 'package:cached_network_image/cached_network_image.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/controllers/utils_controller.dart';
import 'package:dianistana/menu_screens/booking/booking_controller.dart';
import 'package:dianistana/menu_screens/booking/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final BookingController _booking = Get.put(BookingController());
  final UtilsController _utils = Get.put(UtilsController());

  @override
  void initState() {
    _booking.getUnitData();
    super.initState();
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
                    margin: const EdgeInsets.only(top: 5),
                    child: const Text("POWERED BY",
                        style: TextStyle(fontFamily: 'Rubik', fontSize: 10)),
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
                      const Text("BOOKING",
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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Obx(
                    () => _booking.loading.value
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                                child: CircularProgressIndicator()))
                        : Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: _booking.unitList.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => Transaction(
                                        dataList: _booking.unitList[index]));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 9),
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: Constant
                                                            .UNIT_IMAGE +
                                                        _booking.unitList[index]
                                                                ["image"]
                                                            .toString(),
                                                    fit: BoxFit.cover,
                                                    height: 130,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            60,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          left: 10,
                                          bottom: 20,
                                          child: Text(
                                              _booking.unitList[index]
                                                      ['name_unit']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Rubik',
                                                  color: Colors.white)))
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
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
