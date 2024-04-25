import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  String hint;
  TextInputType textInputType;
  IconData iconData;
  TextEditingController textEditingController;
  bool obsecureText;

  InputText(
      {Key? key,
      required this.hint,
      required this.textInputType,
      required this.iconData,
      required this.textEditingController,
      required this.obsecureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(1.0), width: 3.0),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 1), blurRadius: 50, color: Colors.white),
        ],
      ),
      child: TextField(
        controller: textEditingController,
        obscureText: obsecureText,
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: SizedBox(
            height: 30,
            width: 30,
            child: Icon(iconData, color: Colors.green),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
              fontFamily: 'Poppins', fontSize: 15, color: Colors.grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
