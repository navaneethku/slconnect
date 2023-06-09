import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/consts/common_instances.dart';
import 'package:slconnect/onesignal/onesignal_server.dart';

class LandingController extends GetxController {
  //TODO: Implement LandingController
  String? mtoken = "";
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // requestPermission();
    OneSignalService().getUserTokenId();
  }



  void increment() => count.value++;

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted Permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User granted provisional permission");
    } else {
      debugPrint("User declined or has not accepted permission");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mtoken = token;
      debugPrint("My token is $mtoken");
      update();
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(currentUser!.uid)
        .set({
      'token': token,
    });
  }

  bool isSelectedLaborer = false;
  bool isSelectedEmployer = false;
  void selectLaborer() {
    isSelectedEmployer = false;
    isSelectedLaborer = true;
    update();
  }

  void selectEmployer() {
    isSelectedLaborer = false;
    isSelectedEmployer = true;
    update();
  }

  bool isButtonActive = false;
  void checkIsButtonActive() {
    if (isSelectedLaborer || isSelectedEmployer) {
      isButtonActive = true;
    }
    update();
  }

  Future<bool> checkIsLaborer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var laborer = prefs.containsKey('laborer');
    print("Printing Inside checkIsLaborer");
    print(laborer);
    return laborer;
  }
}
