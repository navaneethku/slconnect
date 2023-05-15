import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/app/routes/app_pages.dart';
import 'package:slconnect/consts/colors.dart';

import '../../../../consts/common_styles.dart';
import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<LandingController>(
        builder: (_) => Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.gif"),
                  fit: BoxFit.cover)),
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Select User Type",
                style: largePrimaryBold,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 100,
                height: 100,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    controller.selectLaborer();
                    controller.checkIsButtonActive();
                    controller.update();
                    if (controller.isSelectedLaborer) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('laborer', 'laborer');
                    }
                  },
                  child: Card(
                    color: _.isSelectedLaborer ? secondary : primary,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: const Center(
                        child: Text(
                          "LABORER",
                          style: largeWhiteBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    controller.selectEmployer();
                    controller.checkIsButtonActive();
                    controller.update();
                    if (controller.isSelectedLaborer == false) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('employer', 'employer');
                    }
                  },
                  child: Card(
                    color: _.isSelectedEmployer ? secondary : primary,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: const Center(
                        child: Text(
                          "EMPLOYER",
                          style: largeWhiteBold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    statesController: MaterialStatesController(),
                    onPressed: controller.isButtonActive
                        ? () {
                            Get.offAllNamed(Routes.PROFILE);
                            // controller.update();
                          }
                        : null,
                    child: const Text(
                      "Welcome",
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }
}
