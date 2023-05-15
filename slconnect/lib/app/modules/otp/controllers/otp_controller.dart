import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:slconnect/app/modules/login/controllers/login_controller.dart';

class OtpController extends GetxController {
  //TODO: Implement OtpController
  String verifId = Get.arguments;
  final count = 0.obs;
  String code = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onInit() {
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
