import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:slconnect/app/widgets/BottomNavigation.dart';

import '../controllers/home_laborer_controller.dart';

class HomeLaborerView extends GetView<HomeLaborerController> {
  const HomeLaborerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: 2,
      ),
      appBar: AppBar(
        title: const Text('HomeLaborerView'),
        centerTitle: true,
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
