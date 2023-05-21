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
  var laborer = prefs.getString('laborer');
  var employer = prefs.getString('employer');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    GetMaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: primary),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute:
      //Will Break if user goes to create profile and does not create profile, he/she will be directed to the home page without beingable to create a profile
          phone == null ? AppPages.ISNOTLOGGEDIN : laborer == null?AppPages.HASCREATED_PROFILE_EMPLOYER: employer == null?AppPages.HASCREATED_PROFILE_LABORER: AppPages.ISLOGGEDIN,
      getPages: AppPages.routes,
    ),
  );
}
