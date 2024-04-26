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
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.green,
          ),
          backgroundColor: Colors.white,
          title: const Text(
            "User Data",
            style: TextStyle(color: Colors.green, fontFamily: 'PoppinsBold'),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.all(15),
            child: Obx(
              () => _userData.loading.value
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(child: CircularProgressIndicator()))
                  : ListView(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              "images/top_userdata.png",
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                            Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7))),
                            Obx(() => Center(
                                  child: Column(
                                    children: [
                                      _userData.userData["foto"] != null
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  top: 30),
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 3.0,
                                                      color: Colors.green),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: CachedNetworkImage(
                                                    imageUrl: Constant
                                                            .PROFILE_IMAGE +
                                                        _userData
                                                            .userData['foto']
                                                            .toString(),
                                                    fit: BoxFit.cover),
                                              ),
                                            )
                                          : Container(
                                              margin: const EdgeInsets.only(
                                                  top: 30),
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 3.0,
                                                      color: Colors.green),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Image.asset(
                                                    "images/logo.png",
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                      Jarak(tinggi: 5),
                                      Obx(() => Text(
                                            _userData.userData['name']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 18),
                                          )),
                                      Jarak(tinggi: 2),
                                      Obx(() => Text(
                                            "(${_userData.userData['level'].toString()})",
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15),
                                          ))
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        Jarak(tinggi: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              Spasi(lebar: 10),
                              const Text("Data Perumahan",
                                  style: TextStyle(
                                      fontFamily: 'PoppinsBold',
                                      fontSize: 22,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        Jarak(tinggi: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("BLok",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () =>
                                    Text(_userData.userData["blok"].toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                        )),
                              ),
                            ],
                          ),
                        ),
                        Jarak(tinggi: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Nomor Rumah",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => Text(
                                    _userData.userData["nomor_rumah"]
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Jarak(tinggi: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Pemilik Rumah",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 150,
                                  child: Text(
                                    _userData.userData["name"].toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Alamat",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 150,
                                  child: Text(
                                    _userData.userData["alamat_surat_menyurat"]
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Telepon Rumah",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 140,
                                  child: Text(
                                    _userData.userData["nomor_telepon_rumah"]
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Mulai menempati",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
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
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green,
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
                                child: Text("Instalasi & Kelengkapan",
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Daya Listrik",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
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
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Luas Tanah",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
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
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Iuran Bulanan",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
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
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("ID PDAM",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 150,
                                  child: Text(
                                    _userData.userData["id_pelanggan_pdam"]
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("NO METER PLN",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 150,
                                  child: Text(
                                    _userData.userData["nomor_meter_pln"]
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("WA Emergency",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 150,
                                  child: Text(
                                    _userData.userData["whatsapp_emergency"]
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green,
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
                                child: Text("Informasi Lainnya",
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Whatsapp",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 150,
                                  child: Text(
                                    _userData.userData["no_hp"].toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Jenis Kelamin",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 150,
                                  child: Text(
                                    _userData.userData["jenis_kelamin"]
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Username",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 150,
                                  child: Text(
                                    _userData.userData["username"].toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
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
                              color: Colors.green.withOpacity(0.1),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Email",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 15,
                                  )),
                              Spasi(lebar: 10),
                              Obx(
                                () => SizedBox(
                                  width: 220,
                                  child: Text(
                                    _userData.userData["email"].toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            )));
  }
}
