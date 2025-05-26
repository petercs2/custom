import 'package:custom_clock/pages/clock_config/clock_config_binding.dart';
import 'package:custom_clock/pages/clock_config/clock_config_view.dart';
import 'package:custom_clock/pages/clock_main/clock_main_binding.dart';
import 'package:custom_clock/pages/clock_main/clock_main_view.dart';
import 'package:custom_clock/pages/clock_setting/clock_list.dart';
import 'package:custom_clock/pages/clock_setting/clock_setting_binding.dart';
import 'package:custom_clock/pages/clock_setting/clock_setting_view.dart';
import 'package:custom_clock/pages/not_found/not_found_binding.dart';
import 'package:custom_clock/pages/not_found/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Colors.black;
Color bgColor = Colors.black;

List<Color> colorList = [
  const Color(0xffff0000),
  const Color(0xff74f7d6),
  const Color(0xff007fff),
  const Color(0xffffec5a),
  const Color(0xFF14FF00),
  const Color(0xFFFFFFFF),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? type = prefs.getInt('type');
  if (type == null) {
    await prefs.setInt('type', 0);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: jioays,
      initialRoute: '/clockInit',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> jioays = [
  GetPage(name: '/clockInit', page: () => const ClockConfigView(), binding: ClockConfigBinding()),
  GetPage(name: '/clockMain', page: () => const ClockMainPage(), binding: ClockMainBinding()),
  GetPage(name: '/clockSetting', page: () => const ClockSettingPage(), binding: ClockSettingBinding()),
  GetPage(name: '/clockClean', page: () => const ClockList()),
  GetPage(name: '/notFound', page: () => const NotFoundPage(), binding: NotFoundBinding()),
];
