import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/jarak.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.dataList["name_unit"].toString(),
          style:
              const TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ListView(
          shrinkWrap:true,
          physics: const ScrollPhysics(),
          children: [
            const Text(
              "Please Complete This Form.",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.red,
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
                      child: Icon(Icons.calendar_month, color: Colors.green),
                    ),
                    hintText: "Select Date",
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
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
              const Text("Booking Start Time", style: TextStyle(fontFamily: 'Poppins'),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 105,
                    child: Obx(()

                    
                      => _booking.js6.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))): _booking.jam6.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))): ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "06" ? Colors.orange  : Colors.green.shade300),
                        onPressed: (){
                          _booking.setSelectedHour("06");
                        }, icon: const Icon(Icons.punch_clock), label: const Text("06:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
                    ),
                  ),
                  SizedBox(
                    width:105,
                    child: Obx(() => _booking.js7.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))): _booking.jam7.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "07" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("07");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("07:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  ),
                  SizedBox(
                    width: 105,
                    child: Obx(() =>_booking.js8.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))): _booking.jam8.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "08" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("08");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("08:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 105,
                    child: Obx(() => _booking.js9.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam9.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "09" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("09");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("09:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  ),
                  SizedBox(
                    width:105,
                    child: Obx(() => _booking.js10.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam10.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "10" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("10");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("10:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  ),
                  SizedBox(
                    width: 105,
                    child: Obx(() => _booking.js11.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam11.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "11" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("11");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("11:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 105,
                    child: Obx(() => _booking.js12.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam12.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "12" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("12");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("12:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  ),
                  SizedBox(
                    width:105,
                    child: Obx(() => _booking.js13.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam13.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "13" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("13");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("13:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  ),
                  SizedBox(
                    width: 105,
                    child: Obx(() => _booking.js14.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam14.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "14" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("14");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("14:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 105,
                    child: Obx(() => _booking.js15.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam15.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "15" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("15");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("15:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  ),
                  SizedBox(
                    width:105,
                    child: Obx(() => _booking.js16.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam16.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "16" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("16");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("16:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  ),
                  SizedBox(
                    width: 105,
                    child: Obx(() => _booking.js17.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam17.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "17" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("17");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("17:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 105,
                    child: Obx(() => _booking.js18.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam18.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "18" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("18");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("18:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  ),
                  SizedBox(
                    width:105,
                    child: Obx(() => _booking.js19.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam19.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "19" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("19");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("19:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
                  ),
                  SizedBox(
                    width: 105,
                    child: Obx(() => _booking.js20.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Closed", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):_booking.jam20.value > 0 ? ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green.shade300),
                        onPressed: null, child: const Text("Booked", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: _booking.selectedHour.value == "20" ? Colors.orange  : Colors.green.shade300),
                      onPressed: (){
                        _booking.setSelectedHour("20");
                      }, icon: const Icon(Icons.punch_clock), label: const Text("20:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15)))),
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
      const Text("Booking Finish Time", style: TextStyle(fontFamily: 'Poppins'),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == '06'  ?  ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "07" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("07");
              }, icon: const Icon(Icons.punch_clock), label: const Text("07:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))) : ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("07:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "06" || _booking.selectedHour.value == "07" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "08" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("08");
              }, icon: const Icon(Icons.punch_clock), label: const Text("08:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))) :ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("08:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "06" || _booking.selectedHour.value == "07" || _booking.selectedHour.value == "08" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "09" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("09");
              }, icon: const Icon(Icons.punch_clock), label: const Text("09:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("09:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "07" ||_booking.selectedHour.value == "08" || _booking.selectedHour.value == "09" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "10" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("10");
              }, icon: const Icon(Icons.punch_clock), label: const Text("10:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("10:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "08" ||_booking.selectedHour.value == "09" || _booking.selectedHour.value == "10" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "11" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("11");
              }, icon: const Icon(Icons.punch_clock), label: const Text("11:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("11:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "09" ||_booking.selectedHour.value == "10" || _booking.selectedHour.value == "11" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "12" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("12");
              }, icon: const Icon(Icons.punch_clock), label: const Text("12:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("12:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "10" ||_booking.selectedHour.value == "11" || _booking.selectedHour.value == "12" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "13" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("13");
              }, icon: const Icon(Icons.punch_clock), label: const Text("13:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("13:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "11" ||_booking.selectedHour.value == "12" || _booking.selectedHour.value == "13" ?ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "14" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("14");
              }, icon: const Icon(Icons.punch_clock), label: const Text("14:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("14:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "12" ||_booking.selectedHour.value == "13" || _booking.selectedHour.value == "14" ?ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "15" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("15");
              }, icon: const Icon(Icons.punch_clock), label: const Text("15:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("15:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "13" ||_booking.selectedHour.value == "14" || _booking.selectedHour.value == "15" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "16" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("16");
              }, icon: const Icon(Icons.punch_clock), label: const Text("16:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("16:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "14" ||_booking.selectedHour.value == "15" || _booking.selectedHour.value == "16" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "17" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("17");
              }, icon: const Icon(Icons.punch_clock), label: const Text("17:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("17:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() =>_booking.selectedHour.value == "15" || _booking.selectedHour.value == "16" || _booking.selectedHour.value == "17" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "18" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("18");
              }, icon: const Icon(Icons.punch_clock), label: const Text("18:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("18:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() =>_booking.selectedHour.value == "16" ||_booking.selectedHour.value == "17" || _booking.selectedHour.value == "18" ?  ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "19" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("19");
              }, icon: const Icon(Icons.punch_clock), label: const Text("19:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("19:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "17" ||_booking.selectedHour.value == "18" || _booking.selectedHour.value == "19" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "20" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("20");
              }, icon: const Icon(Icons.punch_clock), label: const Text("20:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("20:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "18" ||_booking.selectedHour.value == "19" || _booking.selectedHour.value == "20" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "21" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("21");
              }, icon: const Icon(Icons.punch_clock), label: const Text("21:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("21:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
    
      Jarak(tinggi: 30),
      Column(
        mainAxisAlignment : MainAxisAlignment.start,
        children:  [
           const Text("By Clicking BOOKING NOW your aggre with our", style:TextStyle(fontFamily: 'Poppins')),
          GestureDetector(
            onTap: (){
              Get.to(()=> const Term());
            },
            child: const Text("Terms and Conditions", style:TextStyle(fontFamily:"PoppinsBold"))),
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
                          fontFamily: 'Poppins',
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
      const Text("Booking Finish Time", style: TextStyle(fontFamily: 'Poppins'),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == '06'  ?  ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "07" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("07");
              }, icon: const Icon(Icons.punch_clock), label: const Text("07:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))) : ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("07:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "06" || _booking.selectedHour.value == "07" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "08" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("08");
              }, icon: const Icon(Icons.punch_clock), label: const Text("08:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))) :ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("08:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "07" || _booking.selectedHour.value == "08" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "09" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("09");
              }, icon: const Icon(Icons.punch_clock), label: const Text("09:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("09:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "08" || _booking.selectedHour.value == "09" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "10" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("10");
              }, icon: const Icon(Icons.punch_clock), label: const Text("10:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("10:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "09" || _booking.selectedHour.value == "10" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "11" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("11");
              }, icon: const Icon(Icons.punch_clock), label: const Text("11:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("11:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "10" || _booking.selectedHour.value == "11" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "12" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("12");
              }, icon: const Icon(Icons.punch_clock), label: const Text("12:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("12:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "11" || _booking.selectedHour.value == "12" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "13" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("13");
              }, icon: const Icon(Icons.punch_clock), label: const Text("13:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("13:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "12" || _booking.selectedHour.value == "13" ?ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "14" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("14");
              }, icon: const Icon(Icons.punch_clock), label: const Text("14:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("14:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "13" || _booking.selectedHour.value == "14" ?ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "15" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("15");
              }, icon: const Icon(Icons.punch_clock), label: const Text("15:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("15:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "14" || _booking.selectedHour.value == "15" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "16" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("16");
              }, icon: const Icon(Icons.punch_clock), label: const Text("16:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("16:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "15" || _booking.selectedHour.value == "16" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "17" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("17");
              }, icon: const Icon(Icons.punch_clock), label: const Text("17:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("17:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "16" || _booking.selectedHour.value == "17" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "18" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("18");
              }, icon: const Icon(Icons.punch_clock), label: const Text("18:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("18:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Obx(() =>_booking.selectedHour.value == "17" || _booking.selectedHour.value == "18" ?  ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "19" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("19");
              }, icon: const Icon(Icons.punch_clock), label: const Text("19:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("19:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width:105,
            child: Obx(() => _booking.selectedHour.value == "18" || _booking.selectedHour.value == "19" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "20" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("20");
              }, icon: const Icon(Icons.punch_clock), label: const Text("20:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("20:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          ),),
          SizedBox(
            width: 105,
            child: Obx(() => _booking.selectedHour.value == "19" || _booking.selectedHour.value == "20" ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: _booking.selectedFinish.value == "21" ? Colors.orange  : Colors.green.shade300),
              onPressed: (){
                _booking.setSelectedFinish("21");
              }, icon: const Icon(Icons.punch_clock), label: const Text("21:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))):ElevatedButton
              (
                style:ElevatedButton.styleFrom(primary:Colors.grey),
                
                onPressed: null, child: const Text("21:00", style:TextStyle(fontFamily: 'PoppinsBold', fontSize: 15))),
          )),
        ],
      ),
    
      Jarak(tinggi: 30),
      Column(
        mainAxisAlignment : MainAxisAlignment.start,
        children:  [
           const Text("By Clicking BOOKING NOW your aggre with our", style:TextStyle(fontFamily: 'Poppins')),
          GestureDetector(
            onTap: (){
              Get.to(()=> const Term());
            },
            child: const Text("Terms and Conditions", style:TextStyle(fontFamily:"PoppinsBold"))),
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
                          fontFamily: 'Poppins',
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


