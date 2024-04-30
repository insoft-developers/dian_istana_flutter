import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/controllers/utils_controller.dart';
import 'package:dianistana/menu_screens/booking/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResumePage extends StatefulWidget {
  Map<String, dynamic> dataList;
  ResumePage({Key? key, required this.dataList}) : super(key: key);

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final BookingController _booking = Get.put(BookingController());
  final UtilsController _utils = Get.put(UtilsController());
  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
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
            "Booking Resume",
            style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ListView(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Facility",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(widget.dataList["name_unit"].toString(),
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Category",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(widget.dataList["kategori"].toString(),
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Transaction Date",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(getCurrentDate(),
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Invoice",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(_booking.invoice.value.toString(),
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Booking Date",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(
                          _utils.getOnlyDate(
                              _booking.selectedDate.value.toString()),
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Package",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(_booking.packageName.value.toString(),
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Start Time",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(_booking.selectedHour.value.toString() + ":00 WIB",
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Finish Time",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(_booking.selectedFinish.value.toString() + ":00 WIB",
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Quantity/Number Of Users",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(_booking.quantity.value.toString(),
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Price",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      Text(
                          "Rp. " +
                              _utils.formatAmount(
                                  _booking.totalPrice.value.toString()),
                          style: const TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15))
                    ],
                  ),
                ),
                Jarak(tinggi: 20),
                ElevatedButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: const Text("BOOKING NOW",
                        style:
                            TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))
              ],
            )));
  }

  showAlertDialog(BuildContext context) {
    BookingController _bookingController = Get.put(BookingController());
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: const Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = FlatButton(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.green,
          ),
          child: const Text("Yes",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ))),
      onPressed: () {
        _bookingController.sendTransaction();
        Get.back();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Booking Confirmation",
          style: TextStyle(
            fontFamily: 'PoppinsBold',
            color: Colors.green,
          )),
      content: const Text("Are you sure to confirm this booking...?",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
          )),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
