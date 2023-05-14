import 'package:flutter/material.dart';

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
              Text(
                "Select User Type",
                style: largePrimaryBold,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    controller.selectLaborer();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('laborer', 'laborer');
                  },
                  child: Card(
                    color: _.isSelectedLaborer ? secondary : primary,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Center(
                        child: Text(
                          "LABORER",
                          style: mediumWhite,
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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('employer', 'employer');
                  },
                  child: Card(
                    color: _.isSelectedEmployer ? secondary : primary,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Center(
                        child: Text(
                          "EMPLOYER",
                          style: mediumWhite,
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
                    onPressed: () {
                      Get.toNamed(Routes.PROFILE);
                    },
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
