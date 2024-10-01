import 'package:dianistana/menu_screens/profile/profile_controller.dart';
import 'package:dianistana/menu_screens/ticketing/ticketing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Select extends StatelessWidget {
  String defValue;
  String hint;
  List<DropdownMenuItem<String>> menuItems;
  String code;

  Select({
    Key? key,
    required this.defValue,
    required this.hint,
    required this.menuItems,
    required this.code,
  }) : super(key: key);

  final ProfileController _profile = Get.put(ProfileController());
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
              height: 25,
              width: 25,
              child: Image.asset("images/gender_i.png"),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
                fontFamily: 'Rubik', fontSize: 13, color: Colors.grey),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          value: defValue,
          onChanged: (String? newValue) {
            _profile.changeSelectedGender(newValue.toString());
          },
          items: menuItems),
    );
  }
}
