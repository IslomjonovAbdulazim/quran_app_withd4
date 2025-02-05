import 'package:flutter/material.dart';

import '../models/surah_model.dart';

class DetailPage extends StatefulWidget {
  final SurahModel surah;

  const DetailPage({super.key, required this.surah});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
