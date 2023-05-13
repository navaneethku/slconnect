import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slconnect/app/routes/app_pages.dart';
import 'package:slconnect/consts/colors.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 18,
      unselectedLabelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      selectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: secondary,
      ),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon:
              Icon(Icons.home, color: currentIndex == 0 ? secondary : primary),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark,
              color: currentIndex == 1 ? secondary : primary),
          label: 'My Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              color: currentIndex == 2 ? secondary : primary),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: secondary,
      showUnselectedLabels: true,
      unselectedItemColor: primary,
      onTap: (int index) {
        switch (index) {
          case 0:
            Get.toNamed(Routes.HOME);
            break;
          case 1:
            Get.toNamed(Routes.BOOKING);
            break;
          case 2:
            Get.toNamed(Routes.PROFILE);
            break;
        }
      },
    );
  }
}
