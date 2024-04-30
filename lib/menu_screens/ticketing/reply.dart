import 'package:dianistana/components/button_color.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/components/textarea.dart';
import 'package:dianistana/menu_screens/ticketing/reply_controller.dart';
import 'package:dianistana/menu_screens/ticketing/ticketing_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class Reply extends StatefulWidget {
  String number;
  Reply({Key? key, required this.number}) : super(key: key);

  @override
  State<Reply> createState() => _ReplyState();
}

class _ReplyState extends State<Reply> {
  final ReplyController _replyController = Get.put(ReplyController());
  final TextEditingController _messageText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Reply ",
          style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            GetBuilder<ReplyController>(builder: (builderController) {
              return GestureDetector(
                onTap: () {
                  builderController.pickImage();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.blue,
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
                hint: "write your reply",
                iconData: Icons.message,
                textEditingController: _messageText,
                maxline: 3),
            Jarak(tinggi: 30),
            Obx(() => _replyController.loading.value
                ? Center(
                    child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      _replyController.replyTicket(
                          widget.number, _messageText.text);
                    },
                    child: ButtonColor(text: "Submit", warna: Colors.green)))
          ],
        ),
      ),
    );
  }
}
