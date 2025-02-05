import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(DevicePreview(builder: (_) => QuranApp()));
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
