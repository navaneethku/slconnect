import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/BottomNavigation.dart';
import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar: const BottomNavigation(
              currentIndex: 1,
            ),
      appBar: AppBar(
        title: const Text('BookingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BookingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
