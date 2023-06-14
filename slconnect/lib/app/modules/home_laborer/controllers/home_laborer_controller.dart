import 'package:get/get.dart';

import '../../../../onesignal/onesignal_server.dart';


class HomeLaborerController extends GetxController {
  //TODO: Implement HomeLaborerController

  final count = 0.obs;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    OneSignalService().getUserTokenId();
  }

  void increment() => count.value++;
  bool laborerIsAvailable = true;
}
