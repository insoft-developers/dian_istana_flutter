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
              Jarak(tinggi: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      "images/logo_line.png",
                      height: 30,
                    ),
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
                      const Text("REPLY",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    children: [
                      GetBuilder<ReplyController>(builder: (builderController) {
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
                                    color: Colors.grey.withOpacity(0.7)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.attach_file,
                                ),
                                Spasi(lebar: 20),
                                Text(
                                    builderController.pickedFile != null
                                        ? "1 file attached"
                                        : "Attach Files.....",
                                    style: const TextStyle(
                                        fontFamily: 'Rubik', fontSize: 15)),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2)),
                              child: const Text("Processing....",
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                            ))
                          : SizedBox(
                              width: 30,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red[900]),
                                  onPressed: () {
                                    _replyController.replyTicket(
                                        widget.number, _messageText.text);
                                  },
                                  child: const Text("Submit",
                                      style: TextStyle(fontFamily: 'Rubik'))),
                            )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
