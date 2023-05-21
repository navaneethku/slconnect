import 'package:get/get.dart';

import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/category_detailed/bindings/category_detailed_binding.dart';
import '../modules/category_detailed/views/category_detailed_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_laborer/bindings/home_laborer_binding.dart';
import '../modules/home_laborer/views/home_laborer_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_laborer/bindings/profile_laborer_binding.dart';
import '../modules/profile_laborer/views/profile_laborer_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const ISNOTLOGGEDIN = Routes.LOGIN;
  static const ISLOGGEDIN = Routes.LANDING;
  static const HASCREATED_PROFILE_LABORER = Routes.HOME_LABORER;
  static const HASCREATED_PROFILE_EMPLOYER = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.HOME_LABORER,
      page: () => const HomeLaborerView(),
      binding: HomeLaborerBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_LABORER,
      page: () => const ProfileLaborerView(),
      binding: ProfileLaborerBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_DETAILED,
      page: () => const CategoryDetailedView(),
      binding: CategoryDetailedBinding(),
    ),
  ];
}
