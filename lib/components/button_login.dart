import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonLogin extends StatelessWidget {
  String text;
  Color warna;
  ButtonLogin({Key? key, required this.text, required this.warna})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: warna.withOpacity(1.0)),
        child: Text(text.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 14)),
      ),
    );
  }
}
