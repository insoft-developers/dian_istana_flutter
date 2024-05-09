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
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Add New Booking",
          style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Obx(
          () => _booking.loading.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _booking.unitList.length,
                  itemBuilder: ((context, index) {
                    String harga_1 = "0";
                    String harga_2 = "0";
                    String harga_3 = "0";
                    String harga_4 = "0";

                    if (_booking.userLevel.value == "user") {
                      harga_1 = "null";
                      harga_2 = "null";
                      harga_3 = _booking.unitList[index]
                              ['harga_warga_1721_weekday']
                          .toString();
                      harga_4 = _booking.unitList[index]
                              ['harga_warga_1721_weekend']
                          .toString();
                    } else {
                      harga_1 = _booking.unitList[index]
                              ['harga_umum_0617_weekday']
                          .toString();
                      harga_2 = _booking.unitList[index]
                              ['harga_umum_0617_weekend']
                          .toString();
                      harga_3 = _booking.unitList[index]
                              ['harga_umum_1721_weekday']
                          .toString();
                      harga_4 = _booking.unitList[index]
                              ['harga_umum_1721_weekend']
                          .toString();
                    }

                    return GestureDetector(
                      onTap: () {
                        Get.to(() =>
                            Transaction(dataList: _booking.unitList[index]));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                        imageUrl: Constant.UNIT_IMAGE +
                                            _booking.unitList[index]["image"]
                                                .toString(),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Spasi(lebar: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      _booking.unitList[index]["name_unit"]
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: 'PoppinsBold',
                                          fontSize: 16),
                                    ),
                                    Text(
                                      _booking.unitList[index]["kategori"]
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Poppins', fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Jarak(tinggi: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "06.00 - 17.00 (Weekday)",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                                Text(
                                    harga_1 == "null"
                                        ? "Free"
                                        : "Rp. " + _utils.formatAmount(harga_1),
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "06.00 - 17.00 (Weekend)",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                  ),
                                ),
                                Text(
                                    harga_2 == "null"
                                        ? "Free"
                                        : "Rp. " + _utils.formatAmount(harga_2),
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15))
                              ],
                            ),
                            Jarak(tinggi: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "17.00 - 21.00 (Weekday)",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                                Text(
                                    harga_3 == "null"
                                        ? "Free"
                                        : "Rp. " + _utils.formatAmount(harga_3),
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "17.00 - 21.00 (Weekend)",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                    harga_4 == "null"
                                        ? "Free"
                                        : "Rp. " + _utils.formatAmount(harga_4),
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
        ),
      ),
    );
  }
}
