import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/consts/colors.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var phone = prefs.getString('phone');
  print(phone);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    GetMaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: primary),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute:
          phone == null ? AppPages.ISNOTLOGGEDIN : AppPages.ISLOGGEDIN,
      getPages: AppPages.routes,
    ),
  );
}
