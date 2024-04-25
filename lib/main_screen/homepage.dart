import 'package:dianistana/components/feature_slider.dart';
import 'package:dianistana/components/input_search.dart';
import 'package:dianistana/components/jarak.dart';
import 'package:dianistana/components/spasi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchs = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(physics: ScrollPhysics(), shrinkWrap: true, children: [
          Jarak(tinggi: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        Icons.location_pin,
                        size: 20,
                        color: Colors.green,
                      )),
                  Spasi(lebar: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "location",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                      ),
                      Text(
                        "Sumatera Utara, Indonesia",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
              Spasi(lebar: 5),
              Row(
                children: [
                  Image.asset(
                    "images/profil.png",
                    height: 40,
                    width: 40,
                  )
                ],
              ),
            ],
          ),
          Jarak(tinggi: 15),
          InputSearch(
              hint: "Search your house",
              textInputType: TextInputType.text,
              iconData: Icons.search,
              textEditingController: _searchs,
              obsecureText: false),
          Jarak(tinggi: 15),
          Stack(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "images/home.png",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange[900]),
                  child: const Text(
                    "featured",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 12),
                  ))
            ],
          ),
          Jarak(tinggi: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/sdp.png",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                    const Text("SDP",
                        style: TextStyle(fontFamily: 'PoppinsBold'))
                  ],
                ),
              ),
              Container(
                width: 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/mdii.png",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                    const Text("DMSI",
                        style: TextStyle(fontFamily: 'PoppinsBold'))
                  ],
                ),
              )
            ],
          ),
          Jarak(tinggi: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Featured Properties",
                  style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 13)),
              Text("See All",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Colors.green)),
            ],
          ),
        ]),
      ),
    );
  }
}
