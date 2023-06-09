import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/app/routes/app_pages.dart';
import 'package:slconnect/app/widgets/BottomNavigation.dart';
import 'package:slconnect/consts/colors.dart';
import 'package:slconnect/consts/common_styles.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(
        builder: (_) => Scaffold(
            bottomNavigationBar: const BottomNavigation(
              currentIndex: 0,
            ),
            appBar: AppBar(
                backgroundColor: secondary,
                title: const Text(
                  "Home",
                  style: largePrimaryBold,
                ),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                        onTap: () => Get.toNamed(Routes.NOTIFICATION),
                        child: const Icon(
                          Icons.notifications_active,
                          color: primary,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                        onTap: () => Get.toNamed(Routes.SETTINGS),
                        child: const Icon(Icons.settings, color: primary)),
                  )
                ]),
            body: SafeArea(
              child: Container(
                  height: screenHeight,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.gif"),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Select Category",
                            style: largePrimaryBold,
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 1,
                                      crossAxisSpacing: 1,
                                      childAspectRatio: 0.95,
                                      crossAxisCount: 2),
                              itemCount: controller.skillsList.length,
                              //DECREASED COUNT FOR AESTHETICS
                              itemBuilder: (BuildContext context, int index) {
                                List blueIndices = [0, 3, 4];
                                Color bgColor = blueIndices.contains(index)
                                    ? primary
                                    : secondary;

                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.CATEGORY_DETAILED,
                                        arguments:
                                            controller.skillsList[index]);
                                  },
                                  child: Card(
                                    color: bgColor,
                                    child: Center(
                                      child: Text(
                                        controller.skillsList[index],
                                        style: mediumWhite,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )),
            )));
  }
}
