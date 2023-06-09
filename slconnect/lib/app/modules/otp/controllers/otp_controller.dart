import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  //TODO: Implement OtpController
  String verifId = Get.arguments;
  final count = 0.obs;
  String code = "";
  final FirebaseAuth auth = FirebaseAuth.instance;



  void increment() => count.value++;
}
