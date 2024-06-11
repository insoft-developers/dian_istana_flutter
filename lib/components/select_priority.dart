import 'package:dianistana/menu_screens/ticketing/ticketing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPriority extends StatelessWidget {
  String defValue;
  String hint;
  List<DropdownMenuItem<String>> menuItems;

  String code;
  IconData iconData;
  SelectPriority(
      {Key? key,
      required this.defValue,
      required this.hint,
      required this.menuItems,
      required this.code,
      required this.iconData})
      : super(key: key);

  final TicketingController _ticketing = Get.put(TicketingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2.0),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 1), blurRadius: 50, color: Colors.white),
        ],
      ),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset("images/power.png"),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
                fontFamily: 'Rubik', fontSize: 13, color: Colors.grey),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          value: defValue,
          onChanged: (String? newValue) {
            _ticketing.changeSelectedPriority(newValue.toString());
          },
          items: menuItems),
    );
  }
}
