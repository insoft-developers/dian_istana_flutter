import 'package:flutter/material.dart';

class Hb extends StatefulWidget {
  Map<String, dynamic> dataList;
  String umur;

  Hb({Key? key, required this.dataList, required this.umur}) : super(key: key);

  @override
  State<Hb> createState() => _HbState();
}

class _HbState extends State<Hb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "images/hb.gif",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: 120,
              child: Text(
                widget.dataList['name'].toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 120,
              child: Column(
                children: [
                  Text(
                    "Ke " + widget.umur,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Wish You All The Best",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
