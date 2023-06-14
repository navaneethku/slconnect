import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/app/widgets/db.dart';
import 'package:slconnect/consts/colors.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("05849719-1b2a-453c-a8d7-981308d70e22");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  OneSignal.shared.setNotificationOpenedHandler((openedResult) {
    Get.toNamed(Routes.NOTIFICATION);
  });
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
          phone == null
              ? AppPages.ISNOTLOGGEDIN
              : laborer == null
                  ? AppPages.HASCREATED_PROFILE_EMPLOYER
                  : employer == null
                      ? AppPages.HASCREATED_PROFILE_LABORER
                      : AppPages.ISLOGGEDIN,
      getPages: AppPages.routes,
    ),
  );
}
