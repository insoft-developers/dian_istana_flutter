import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/input_custom.dart';
import 'package:dianistana/components/input_reguler.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/select_department.dart';
import 'package:dianistana/components/select_priority.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/components/textarea.dart';
import 'package:dianistana/components/textarea_custom.dart';
import 'package:dianistana/menu_screens/ticketing/ticketing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({Key? key}) : super(key: key);

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final TicketingController _ticketingController =
      Get.put(TicketingController());
  final TextEditingController _subjectText = TextEditingController();
  final TextEditingController _messageText = TextEditingController();

  @override
  void initState() {
    _ticketingController.getDepartmentData().then((value) {
      _ticketingController.changeSelectedDepartment("5");
    });
    _ticketingController.changeSelectedPriority("Medium");
    _ticketingController.resetPicker();

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
                      const Text("ADD NEW TICKET",
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: [
                        Obx(
                          () => SelectDepartment(
                              defValue: _ticketingController
                                  .defaultDepartmentValue.value,
                              hint: "select department",
                              menuItems:
                                  _ticketingController.dropdownDepartment,
                              code: "select_department",
                              iconData: Icons.build),
                        ),
                        Jarak(tinggi: 15),
                        Obx(
                          () => SelectPriority(
                              defValue: _ticketingController
                                  .defaultPriorityValue.value,
                              hint: "select priority",
                              menuItems: _ticketingController.dropdownPriority,
                              code: "select_priority",
                              iconData: Icons.priority_high),
                        ),
                        Jarak(tinggi: 15),
                        InputCustom(
                            hint: "Enter Subject",
                            textInputType: TextInputType.text,
                            imageLink: "images/electric.png",
                            textEditingController: _subjectText,
                            obsecureText: false),
                        Jarak(tinggi: 15),
                        GetBuilder<TicketingController>(
                            builder: (builderController) {
                          return GestureDetector(
                            onTap: () {
                              builderController.pickImage();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Spasi(lebar: 10),
                                  Image.asset(
                                    "images/attach.png",
                                    height: 30,
                                  ),
                                  Spasi(lebar: 20),
                                  Text(
                                      builderController.pickedFile != null
                                          ? "1 file attached"
                                          : "Attach Files.....",
                                      style: const TextStyle(
                                          fontFamily: 'Poppins', fontSize: 15)),
                                ],
                              ),
                            ),
                          );
                        }),
                        Jarak(tinggi: 15),
                        Stack(
                          children: [
                            TextAreaCustom(
                                hint: "Please let us know how we can help you",
                                iconData: Icons.report_problem,
                                textEditingController: _messageText,
                                maxline: 10),
                            Positioned(
                              bottom: 10,
                              left: 20,
                              child: Obx(() => _ticketingController
                                      .openLoading.value
                                  ? Center(
                                      child: Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: const Text("Processing....",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold)),
                                    ))
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red[900]),
                                      onPressed: () {
                                        _ticketingController.openTicket(
                                            _subjectText.text,
                                            _messageText.text);
                                      },
                                      child: const Text("Submit",
                                          style:
                                              TextStyle(fontFamily: 'Poppins')),
                                    )),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              Jarak(tinggi: 30)
            ],
          ),
        ),
      ],
    );
  }
}
