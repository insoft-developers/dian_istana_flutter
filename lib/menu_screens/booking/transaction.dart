import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/menu_screens/booking/booking_controller.dart';
import 'package:dianistana/menu_screens/booking/term.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Transaction extends StatefulWidget {
  Map<String, dynamic> dataList;
  Transaction({Key? key, required this.dataList}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final TextEditingController _tanggal = TextEditingController();
  final BookingController _booking = Get.put(BookingController());

  @override
  void initState() {
    _booking.setSelectedHour("");
    _booking.setSelectedFinish("");
    _booking.selectedDate.value = "";
    _tanggal.text = "";
    _booking.unitId.value = widget.dataList["id"].toString();
    _booking.unitKategori.value = widget.dataList['kategori'].toString();
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
          backgroundColor:Colors.transparent,
         
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
                          Text(widget.dataList["name_unit"].toString(),
                              style: const TextStyle(
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
                  margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: ListView(
                    shrinkWrap:true,
                    physics: const ScrollPhysics(),
                    children: [
                    Jarak(tinggi: 5),
                      const Text(
                        "Please Complete This Form.",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize:12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Jarak(tinggi: 10),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade300,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5), width: 2.0),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 50,
                                color: Colors.white),
                          ],
                        ),
                        child: TextField(
                            controller: _tanggal,
                            obscureText: false,
                            keyboardType: TextInputType.datetime,
                            textInputAction: TextInputAction.next,
                            readOnly: true,
                            decoration: const InputDecoration(
                              icon: SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.calendar_month, color: Colors.grey),
                              ),
                              hintText: "Select Date",
                              hintStyle: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 15,
                                  color: Colors.grey),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(), 
                                  firstDate: DateTime.now()
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate = DateFormat('yyyy-MM-dd').format(
                                    pickedDate); 
                                
                                setState(() {
                                  _tanggal.text =
                                      formattedDate; 
                                    _booking.selectedDate.value = "";
                                });
                              } else {
                                print("Date is not selected");
                              }
                            }),
                      ),
                      Jarak(tinggi: 5),
                      Obx(()
                        => _booking.showHourLoading.value ? const SizedBox(
                          height: 60,
                          child:  Center(child: CircularProgressIndicator()))
               : ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(primary: Colors.black54),
                            onPressed: () {
                              _booking.selectBookingDate(_tanggal.text);
                            },
                            icon: const Icon(Icons.lock_clock),
                            label: const Text("Show Booking Time :")),
                            
                      ),
                      Jarak(tinggi: 10),
                      Obx(()
                        => _booking.selectedDate.value == "" ? const SizedBox() : ListView(
                          shrinkWrap: true,
                          physics:const ScrollPhysics(),
                          children: [
                        const Text("Booking Start Time", style: TextStyle(fontFamily: 'Rubik'),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Obx(()
              
                              
                                => _booking.js6.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))): _booking.jam6.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))): ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "06" ? Colors.red[900]  : Colors.black54),
                                  onPressed: (){
                                    _booking.setSelectedHour("06");
                                  },  child: const Text("06:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
                              ),
                            ),
                            SizedBox(
                              width:105,
                              child: Obx(() => _booking.js7.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))): _booking.jam7.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "07" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("07");
                                },  child: const Text("07:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            ),
                            SizedBox(
                              width: 100,
                              child: Obx(() =>_booking.js8.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))): _booking.jam8.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "08" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("08");
                                },  child: const Text("08:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Obx(() => _booking.js9.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam9.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "09" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("09");
                                },  child: const Text("09:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            ),
                            SizedBox(
                              width:105,
                              child: Obx(() => _booking.js10.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam10.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "10" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("10");
                                },  child: const Text("10:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            ),
                            SizedBox(
                              width: 100,
                              child: Obx(() => _booking.js11.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam11.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "11" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("11");
                                },  child: const Text("11:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Obx(() => _booking.js12.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam12.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "12" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("12");
                                },  child: const Text("12:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            ),
                            SizedBox(
                              width:105,
                              child: Obx(() => _booking.js13.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam13.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "13" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("13");
                                },  child: const Text("13:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            ),
                            SizedBox(
                              width: 100,
                              child: Obx(() => _booking.js14.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam14.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "14" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("14");
                                },  child: const Text("14:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Obx(() => _booking.js15.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam15.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "15" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("15");
                                },  child: const Text("15:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            ),
                            SizedBox(
                              width:105,
                              child: Obx(() => _booking.js16.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam16.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "16" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("16");
                                },  child: const Text("16:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            ),
                            SizedBox(
                              width: 100,
                              child: Obx(() => _booking.js17.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam17.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "17" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("17");
                                },  child: const Text("17:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Obx(() => _booking.js18.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam18.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "18" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("18");
                                },  child: const Text("18:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            ),
                            SizedBox(
                              width:105,
                              child: Obx(() => _booking.js19.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam19.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "19" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("19");
                                },  child: const Text("19:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            ),
                            SizedBox(
                              width: 100,
                              child: Obx(() => _booking.js20.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):_booking.jam20.value > 0 ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                                  onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "20" ? Colors.red[900]  : Colors.black54),
                                onPressed: (){
                                  _booking.setSelectedHour("20");
                                },  child: const Text("20:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15)))),
                            )
                          ],
                        ),
                          ]),
                      ),
              
              
                      Obx(()=> _booking.unitKategori.value == "Komunal Space" ? Comunal(booking: _booking, widget: widget) : NonComunal(booking: _booking, widget: widget)),
                     
                      Jarak(tinggi: 30),
                    
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

class Comunal extends StatelessWidget {
  const Comunal({
    Key? key,
    required BookingController booking,
    required this.widget,
  }) : _booking = booking, super(key: key);

  final BookingController _booking;
  final Transaction widget;

  @override
  Widget build(BuildContext context) {
    return Obx(()
      => _booking.selectedDate.value == "" ? const SizedBox() : ListView(
        shrinkWrap:true,
        physics : const ScrollPhysics(),
        children: [
      Jarak(tinggi: 10),
      const Text("Booking Finish Time", style: TextStyle(fontFamily: 'Rubik'),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == '06'  ?  ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "07" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("07");
              },  child: const Text("07:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("07:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "06" || _booking.selectedHour.value == "07" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "08" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("08");
              },  child: const Text("08:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) :ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("08:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "06" || _booking.selectedHour.value == "07" || _booking.selectedHour.value == "08" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "09" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("09");
              },  child: const Text("09:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("09:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "07" ||_booking.selectedHour.value == "08" || _booking.selectedHour.value == "09" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "10" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("10");
              },  child: const Text("10:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("10:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "08" ||_booking.selectedHour.value == "09" || _booking.selectedHour.value == "10" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "11" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("11");
              },  child: const Text("11:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("11:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "09" ||_booking.selectedHour.value == "10" || _booking.selectedHour.value == "11" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "12" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("12");
              },  child: const Text("12:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("12:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "10" ||_booking.selectedHour.value == "11" || _booking.selectedHour.value == "12" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "13" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("13");
              },  child: const Text("13:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("13:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "11" ||_booking.selectedHour.value == "12" || _booking.selectedHour.value == "13" ?ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "14" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("14");
              },  child: const Text("14:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("14:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "12" ||_booking.selectedHour.value == "13" || _booking.selectedHour.value == "14" ?ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "15" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("15");
              },  child: const Text("15:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("15:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "13" ||_booking.selectedHour.value == "14" || _booking.selectedHour.value == "15" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "16" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("16");
              },  child: const Text("16:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("16:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "14" ||_booking.selectedHour.value == "15" || _booking.selectedHour.value == "16" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "17" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("17");
              },  child: const Text("17:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("17:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() =>_booking.selectedHour.value == "15" || _booking.selectedHour.value == "16" || _booking.selectedHour.value == "17" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "18" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("18");
              },  child: const Text("18:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("18:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() =>_booking.selectedHour.value == "16" ||_booking.selectedHour.value == "17" || _booking.selectedHour.value == "18" ?  ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "19" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("19");
              },  child: const Text("19:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("19:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "17" ||_booking.selectedHour.value == "18" || _booking.selectedHour.value == "19" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "20" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("20");
              },  child: const Text("20:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("20:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "18" ||_booking.selectedHour.value == "19" || _booking.selectedHour.value == "20" ? ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "21" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("21");
              },  child: const Text("21:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("21:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
    
      Jarak(tinggi: 30),
      Column(
        mainAxisAlignment : MainAxisAlignment.start,
        children:  [
           const Text("By Clicking BOOKING NOW your aggre with our", style:TextStyle(fontFamily: 'Rubik')),
          GestureDetector(
            onTap: (){
              Get.to(()=> const Term());
            },
            child: const Text("Terms and Conditions", style:TextStyle(fontFamily:"RubikBold"))),
        ],
      ),
      Jarak(tinggi: 20),
      Obx(() 
        => _booking.resumeLoading.value ? Center(
                  child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2)),
                  child: const Text("Processing....",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                ))
: GestureDetector(
          onTap:() {
            _booking.bookingResume(widget.dataList);
          },
          child: ButtonColor(text: "BOOKING NOW", warna: Colors.blue)),
      ),
        ]
      ),
    );
  }
}



class NonComunal extends StatelessWidget {
  const NonComunal({
    Key? key,
    required BookingController booking,
    required this.widget,
  }) : _booking = booking, super(key: key);

  final BookingController _booking;
  final Transaction widget;

  @override
  Widget build(BuildContext context) {
    return Obx(()
      => _booking.selectedDate.value == "" ? const SizedBox() : ListView(
        shrinkWrap:true,
        physics : const ScrollPhysics(),
        children: [
      Jarak(tinggi: 10),
      const Text("Booking Finish Time", style: TextStyle(fontFamily: 'Rubik'),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == '06'  ? _booking.off_finish == "07" ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("07:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "07" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("07");
              },  child: const Text("07:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("07:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "06" || _booking.selectedHour.value == "07" ? _booking.off_finish == "08" ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("08:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "08" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("08");
              },  child: const Text("08:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) :ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("08:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "07" || _booking.selectedHour.value == "08" ? _booking.off_finish == "09" ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("09:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "09" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("09");
              },  child: const Text("09:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("09:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "08" || _booking.selectedHour.value == "09" ? _booking.off_finish == 10 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("10:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "10" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("10");
              },  child: const Text("10:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("10:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "09" || _booking.selectedHour.value == "10" ? _booking.off_finish == 11 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("11:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "11" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("11");
              },  child: const Text("11:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("11:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "10" || _booking.selectedHour.value == "11" ? _booking.off_finish == 12 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("12:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "12" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("12");
              },  child: const Text("12:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("12:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "11" || _booking.selectedHour.value == "12" ? _booking.off_finish == 13 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("13:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "13" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("13");
              },  child: const Text("13:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("13:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "12" || _booking.selectedHour.value == "13" ? _booking.off_finish == 14 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("14:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "14" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("14");
              },  child: const Text("14:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("14:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "13" || _booking.selectedHour.value == "14" ? _booking.off_finish == 15 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("15:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "15" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("15");
              },  child: const Text("15:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("15:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "14" || _booking.selectedHour.value == "15" ? _booking.off_finish == 16 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("16:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "16" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("16");
              },  child: const Text("16:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("16:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "15" || _booking.selectedHour.value == "16" ? _booking.off_finish == 17 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("17:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "17" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("17");
              },  child: const Text("17:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("17:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "16" || _booking.selectedHour.value == "17" ? _booking.off_finish == 18 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("18:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "18" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("18");
              },  child: const Text("18:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("18:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Obx(() =>_booking.selectedHour.value == "17" || _booking.selectedHour.value == "18" ? _booking.off_finish == 19 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("19:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "19" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("19");
              },  child: const Text("19:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("19:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "18" || _booking.selectedHour.value == "19" ? _booking.off_finish == 20 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("20:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) :ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "20" ? Colors.red[900]  :  Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("20");
              },  child: const Text("20:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("20:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 100,
            child: Obx(() => _booking.selectedHour.value == "19" || _booking.selectedHour.value == "20" ? _booking.off_finish == 21 ? ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("21:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))) : ElevatedButton(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "21" ? Colors.red[900]  : Colors.black54),
              onPressed: (){
                _booking.setSelectedFinish("21");
              },  child: const Text("21:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("21:00", style:TextStyle(fontFamily: 'RubikBold', fontSize: 15))),
          )),
        ],
      ),
    
      Jarak(tinggi: 30),
      Column(
        mainAxisAlignment : MainAxisAlignment.start,
        children:  [
           const Text("By Clicking BOOKING NOW your aggre with our", style:TextStyle(fontFamily: 'Rubik')),
          GestureDetector(
            onTap: (){
              Get.to(()=> const Term());
            },
            child: const Text("Terms and Conditions", style:TextStyle(fontFamily:"RubikBold"))),
        ],
      ),
      Jarak(tinggi: 20),
      Obx(() 
        => _booking.resumeLoading.value ? Center(
                  child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2)),
                  child: const Text("Processing....",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                ))
: GestureDetector(
          onTap:() {
            _booking.bookingResume(widget.dataList);
          },
          child: ButtonColor(text: "BOOKING NOW", warna: Colors.black54)),
      ),
        ]
      ),
    );
  }
}


