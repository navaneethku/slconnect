import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:slconnect/app/widgets/BottomNavigation.dart';

import '../../../../consts/colors.dart';
import '../../../../consts/common_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_laborer_controller.dart';

class HomeLaborerView extends GetView<HomeLaborerController> {
  const HomeLaborerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: secondary,
          title: const Text(
            "Home Labour View",
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
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0,
      ),
      body: const Center(
        child: Text(
          'HomeLaborerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
