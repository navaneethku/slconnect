import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/BottomNavigation.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar: const BottomNavigation(
              currentIndex: 2,
            ),
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
