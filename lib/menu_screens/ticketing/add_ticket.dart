import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/input_reguler.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/select_department.dart';
import 'package:dianistana/components/select_priority.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/components/textarea.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Add New Ticket",
          style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              Obx(
                () => SelectDepartment(
                    defValue: _ticketingController.defaultDepartmentValue.value,
                    hint: "select department",
                    menuItems: _ticketingController.dropdownDepartment,
                    code: "select_department",
                    iconData: Icons.build),
              ),
              Jarak(tinggi: 15),
              Obx(
                () => SelectPriority(
                    defValue: _ticketingController.defaultPriorityValue.value,
                    hint: "select priority",
                    menuItems: _ticketingController.dropdownPriority,
                    code: "select_priority",
                    iconData: Icons.priority_high),
              ),
              Jarak(tinggi: 15),
              InputReguler(
                  hint: "Enter Subject",
                  textInputType: TextInputType.text,
                  iconData: Icons.subject,
                  textEditingController: _subjectText,
                  obsecureText: false),
              Jarak(tinggi: 15),
              GetBuilder<TicketingController>(builder: (builderController) {
                return GestureDetector(
                  onTap: () {
                    builderController.pickImage();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.attach_file,
                          color: Colors.white,
                        ),
                        Spasi(lebar: 20),
                        Text(
                            builderController.pickedFile != null
                                ? "1 file attached"
                                : "Attach Files.....",
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                );
              }),
              Jarak(tinggi: 15),
              TextArea(
                  hint: "tell us what can we help for you",
                  iconData: Icons.report_problem,
                  textEditingController: _messageText,
                  maxline: 3),
              Jarak(tinggi: 30),
              Obx(() => _ticketingController.openLoading.value
                  ? Center(
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
                      onTap: () {
                        _ticketingController.openTicket(
                            _subjectText.text, _messageText.text);
                      },
                      child: ButtonColor(text: "Submit", warna: Colors.green)))
            ],
          )),
    );
  }
}
