import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/app/routes/app_pages.dart';
import 'package:slconnect/consts/colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      physics: const BouncingScrollPhysics(),
      child: Container(
          height: screenHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.gif"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(10, screenWidth / 3, 10, screenWidth / 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("SL Connect",
                    style: TextStyle(
                      fontSize: 38,
                    )),
                // Lottie.asset("assets/lottie/signuplady.json"),
                Image.asset(
                  'assets/images/login_background.png',
                  width: 250,
                  height: 250,
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Phone Verification",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "We need to register your phone before getting started!",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                controller: controller.countryController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Text(
                              "|",
                              style:
                                  TextStyle(fontSize: 33, color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Form(
                              key: controller.loginFormKey,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 10) {
                                    return "Please Enter A Valid Phone Number";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  controller.phone = value;
                                },
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Phone",
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).dialogBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () async {
                            if (controller.loginFormKey.currentState!.validate()) {
                              controller.showOTPSnackBar();
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: controller.countryController.text +
                                    controller.phone,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException e) {},
                                codeSent: (String verificationId,
                                    int? resendToken) async {
                                  controller.verifId = verificationId;
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('phone', controller.phone);
                                  Get.offAllNamed(Routes.OTP,arguments: controller.verifId);
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            }
                          },
                          child: const Text(
                            "Send the code",
                            style: TextStyle(color: primary),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
