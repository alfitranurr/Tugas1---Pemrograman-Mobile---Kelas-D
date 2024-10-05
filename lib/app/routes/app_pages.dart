import 'package:get/get.dart';
import 'package:kesehatan/app/modules/login/views/login_view.dart';
import 'package:kesehatan/app/modules/profile/views/profile_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/splash_screen/bindings/splashscreen_binding.dart';
import '../modules/splash_screen/views/splashscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // Rute awal diubah menjadi SplashScreen agar user pertama kali melihat splash screen
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
   
  ];
}
