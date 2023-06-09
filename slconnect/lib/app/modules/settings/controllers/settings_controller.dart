import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slconnect/consts/common_instances.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController

  final count = 0.obs;
  @override
  void onInit() {
    debugPrint(currentUser?.uid);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
