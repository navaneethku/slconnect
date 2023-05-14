import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  @override
  void onInit() {
    countryController.text = "+91";
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
  final formKey = GlobalKey<FormState>();
  void increment() => count.value++;
  String verifId = "";
  String phone = "";
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  Future verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 80 7875 6904',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    FirebaseAuth auth = FirebaseAuth.instance;

    // await auth.verifyPhoneNumber(
    //   phoneNumber: '+91 80 7875 6904',
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //     // ANDROID ONLY!

    //     // Sign the user in (or link) with the auto-generated credential
    //     await auth.signInWithCredential(credential);
    //   },
    //   verificationFailed: (FirebaseAuthException e) {
    //     if (e.code == 'invalid-phone-number') {
    //       print('The provided phone number is not valid.');
    //     }
    //   },
    //   codeSent: (String verificationId, int? resendToken) async {
    //     // Update the UI - wait for the user to enter the SMS code
    //     String smsCode = '1000';

    //     // Create a PhoneAuthCredential with the code
    //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //         verificationId: verificationId, smsCode: smsCode);

    //     // Sign the user in (or link) with the credential
    //     await auth.signInWithCredential(credential);
    //   },
    //   timeout: const Duration(seconds: 60),
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //     // Auto-resolution timed out...
    //   },
    // );
  }

  void showOTPSnackBar() {
    Get.showSnackbar(const GetSnackBar(
      duration: Duration(seconds: 4),
      message: 'Please wait for the OTP to arrive',
    ));
  }
}
