import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextArea extends StatelessWidget {
  String hint;
  IconData iconData;

  int maxline;

  TextEditingController textEditingController;

  TextArea(
      {Key? key,
      required this.hint,
      required this.iconData,
      required this.textEditingController,
      required this.maxline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 54),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        border: Border.all(color: Colors.grey.withOpacity(0.7)),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 1), blurRadius: 50, color: Colors.white),
        ],
      ),
      child: TextField(
        controller: textEditingController,
        obscureText: false,
        keyboardType: TextInputType.multiline,
        maxLines: maxline,
        decoration: InputDecoration(
          icon: SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              iconData,
              color: Colors.grey,
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
              fontFamily: 'Poppins', fontSize: 13, color: Colors.grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
