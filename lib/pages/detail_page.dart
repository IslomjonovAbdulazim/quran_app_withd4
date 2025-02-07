import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

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
  int? currentPlaying;
  bool isLoading = false;
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    load();
    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        if (currentPlaying != null && currentPlaying! < widget.surah.verses) {
          currentPlaying = currentPlaying!;
          playAudio(ayahs[currentPlaying!]);
        } else {
          currentPlaying = null;
        }
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void load() async {
    String data = await rootBundle.loadString("assets/ayah.json");
    List listData = List.from(jsonDecode(data))[widget.surah.id - 1]["verses"];
    ayahs = listData.map((json) => AyahModel.from(json)).toList();
    setState(() {});
  }

  void playAudio(AyahModel ayah) async {
    if (currentPlaying == null || currentPlaying != ayah.id) {
      isLoading = true;
      currentPlaying = ayah.id;
      setState(() {});
      String surah = widget.surah.id.toString().padLeft(3, "0");
      String verse = ayah.id.toString().padLeft(3, "0");
      await player.setUrl(
          "https://everyayah.com/data/Alafasy_128kbps/$surah$verse.mp3");
      isLoading = false;
      setState(() {});
      player.play();
    } else {
      if (player.playing) {
        player.pause();
      } else {
        player.play();
      }
    }
    currentPlaying = ayah.id;
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
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15),
          itemCount: ayahs.length,
          itemBuilder: (_, int index) {
            AyahModel ayah = ayahs[index];
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
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
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: currentPlaying == ayah.id && isLoading
                            ? CircularProgressIndicator.adaptive()
                            : CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  playAudio(ayah);
                                },
                                child: Icon(
                                  player.playing && currentPlaying == ayah.id
                                      ? CupertinoIcons.pause
                                      : CupertinoIcons.play,
                                  color: Color(0xffA44AFF),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: currentPlaying == ayah.id ? Color(0xff121931) : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                ),
                SizedBox(height: 3),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ayah.translation,
                    style: GoogleFonts.poppins(
                      color: Color(0xffA19CC5),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
