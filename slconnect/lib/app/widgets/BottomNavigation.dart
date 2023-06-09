import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slconnect/app/routes/app_pages.dart';
import 'package:slconnect/consts/colors.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
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
            icon: Icon(Icons.home,
                color: widget.currentIndex == 0 ? secondary : primary),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark,
                color: widget.currentIndex == 1 ? secondary : primary),
            label: 'My Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: widget.currentIndex == 2 ? secondary : primary),
            label: 'Profile',
          ),
        ],
        currentIndex: widget.currentIndex,
        selectedItemColor: secondary,
        showUnselectedLabels: true,
        unselectedItemColor: primary,
        onTap: (int index) async {
          var prefs = await SharedPreferences.getInstance();
          if (prefs.containsKey("laborer") == true) {
            switch (index) {
              case 0:
                Get.offAllNamed(Routes.HOME_LABORER);
                break;
              case 1:
                Get.offAllNamed(Routes.BOOKING);
                break;
              case 2:
                Get.offAllNamed(Routes.PROFILE_LABORER);
            }
          } else {
            switch (index) {
              case 0:
                Get.offNamed(Routes.HOME);
                break;
              case 1:
                Get.offNamed(Routes.BOOKING);
                break;
              case 2:
                Get.offNamed(Routes.PROFILE);
            }
          }
        });
  }
}
