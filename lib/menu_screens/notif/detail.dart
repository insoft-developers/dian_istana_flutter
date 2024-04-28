import 'package:cached_network_image/cached_network_image.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/constant.dart';
import 'package:flutter/material.dart';

class NotifDetail extends StatefulWidget {
  Map<String, dynamic> dataList;
  NotifDetail({Key? key, required this.dataList}) : super(key: key);

  @override
  State<NotifDetail> createState() => _NotifDetailState();
}

class _NotifDetailState extends State<NotifDetail> {
  @override
  void initState() {
    print(widget.dataList);
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
          "",
          style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ListView(
          children: [
            Text(widget.dataList["title"],
                style:
                    const TextStyle(fontFamily: 'PoppinsBold', fontSize: 22)),
            Jarak(tinggi: 15),
            widget.dataList["image"] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                        imageUrl: Constant.NOTIF_IMAGE +
                            widget.dataList["image"].toString(),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width),
                  )
                : const SizedBox(),
            Jarak(tinggi: 20),
            Text(widget.dataList["message"],
                style: const TextStyle(
                  fontFamily: 'Poppins',
                )),
            Jarak(tinggi: 20),
            Text(
                widget.dataList["admin_name"] + ", " + widget.dataList["waktu"],
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
