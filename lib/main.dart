import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games/features/myApp/presentation/pages/my_app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(
    const MyApp(),
  );
}
