import 'package:cached_network_image/cached_network_image.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:dianistana/constant.dart';
import 'package:dianistana/controllers/utils_controller.dart';
import 'package:dianistana/menu_screens/userdata/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final UserDataController _userData = Get.put(UserDataController());
  final UtilsController _utils = Get.put(UtilsController());

  @override
  void initState() {
    _userData.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/white_bg.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Jarak(tinggi: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Text("POWERED BY",
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 10)),
                    ),
                    Image.asset(
                      "images/logo_line.png",
                      height: 22,
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
                        Image.asset(
                          "images/left.png",
                          height: 30,
                          width: 30,
                        ),
                        Spasi(lebar: 10),
                        const Text("USER DATA",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(15),
                      child: Obx(
                        () => _userData.loading.value
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: const Center(
                                    child: CircularProgressIndicator()))
                            : ListView(
                                children: [
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.install_desktop,
                                          color: Colors.white,
                                        ),
                                        Spasi(lebar: 10),
                                        const SizedBox(
                                          width: 200,
                                          child: Text("Main Data",
                                              style: TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 22,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Cluster Block",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => Text(
                                              _userData.userData["blok"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("House Number",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => Text(
                                              _userData.userData["nomor_rumah"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Owner Name",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData.userData["name"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Address",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData.userData[
                                                      "alamat_surat_menyurat"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Phone",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 140,
                                            child: Text(
                                              _userData.userData[
                                                      "nomor_telepon_rumah"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Start Occupying",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 130,
                                            child: Text(
                                              _utils.getFormattedDate(_userData
                                                  .userData["mulai_menempati"]
                                                  .toString()),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.install_desktop,
                                          color: Colors.white,
                                        ),
                                        Spasi(lebar: 10),
                                        const SizedBox(
                                          width: 200,
                                          child: Text("Instalation & Equipment",
                                              style: TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 22,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Electric Power",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData.userData["daya_listrik"]
                                                      .toString() +
                                                  " WATT",
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Surface Area",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData.userData["luas_tanah"]
                                                      .toString() +
                                                  " m2",
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Monthly Fees",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _utils.formatAmount(_userData
                                                  .userData["iuran_bulanan"]
                                                  .toString()),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("ID PDAM",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData
                                                  .userData["id_pelanggan_pdam"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("NO METER PLN",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData
                                                  .userData["nomor_meter_pln"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Emergency WA",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData.userData[
                                                      "whatsapp_emergency"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.install_desktop,
                                          color: Colors.white,
                                        ),
                                        Spasi(lebar: 10),
                                        const SizedBox(
                                          width: 220,
                                          child: Text("Other Informations",
                                              style: TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 22,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Whatsapp",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData.userData["no_hp"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Gender",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData
                                                  .userData["jenis_kelamin"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Username",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 150,
                                            child: Text(
                                              _userData.userData["username"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Email",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                            )),
                                        Spasi(lebar: 10),
                                        Obx(
                                          () => SizedBox(
                                            width: 220,
                                            child: Text(
                                              _userData.userData["email"]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Jarak(tinggi: 30),
                                ],
                              ),
                      )),
                ),
              ],
            )),
      ],
    );
  }
}
