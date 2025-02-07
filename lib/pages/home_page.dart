import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/surah_model.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SurahModel> surahs = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    String data = await rootBundle.loadString("assets/surah.json");
    List listData = List.from(jsonDecode(data));
    surahs = listData.map((json) => SurahModel.fromJson(json)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040C23),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: surahs.length,
          itemBuilder: (_, int index) {
            SurahModel surah = surahs[index];
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(surah: surah),
                  ),
                );
              },
              child: ListTile(
                leading: Text(
                  surah.id.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                title: Text(
                  surah.transliteration,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "${surah.type.toUpperCase()}  ${surah.verses} VERSES",
                  style: GoogleFonts.poppins(
                    color: Color(0xffA19CC5),
                    fontSize: 12,
                  ),
                ),
                trailing: Text(
                  surah.name,
                  style: GoogleFonts.amiri(
                    color: Color(0xffA44AFF),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
