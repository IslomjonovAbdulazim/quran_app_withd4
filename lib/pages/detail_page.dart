import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/ayah_model.dart';
import '../models/surah_model.dart';

class DetailPage extends StatefulWidget {
  final SurahModel surah;

  const DetailPage({super.key, required this.surah});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<AyahModel> ayahs = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    String data = await rootBundle.loadString("assets/ayah.json");
    List listData = List.from(jsonDecode(data))[widget.surah.id - 1]["verses"];
    ayahs = listData.map((json) => AyahModel.from(json)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040C23),
      appBar: AppBar(
        backgroundColor: Color(0xff040C23),
        surfaceTintColor: Color(0xff040C23),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Color(0xffA19CC5),
          ),
        ),
        centerTitle: false,
        title: Text(
          widget.surah.transliteration,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: ayahs.length,
        itemBuilder: (_, int index) {
          AyahModel ayah = ayahs[index];
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff121931),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Color(0xffA44AFF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          ayah.id.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      CupertinoIcons.play,
                      color: Color(0xffA44AFF),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  ayah.text,
                  style: GoogleFonts.amiri(
                    color: Colors.white,
                    fontSize: 25,
                    height: 2.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Text(
                ayah.translation,
                style: GoogleFonts.poppins(
                  color: Color(0xffA19CC5),
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
