import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:happy_messanger/app/data/localization.dart';
import 'package:happy_messanger/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:happy_messanger/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DashboardBinding().dependencies();
  await GetStorage.init();

  final box = GetStorage();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          // primary: const Colors.yellow[700],
          // secondary: const Colors.yellow.shade700,
          // or from RGB
          primary: const Color(0xFF8c77ec),
          secondary: const Color(0xFFFFC107),
        ),
        tabBarTheme: TabBarTheme(
            labelColor: Colors.pink[800],
            labelStyle: TextStyle(color: Colors.pink[800]), // color for text
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.red))),
        primaryColor: Colors.pink[800], // outdated and has no effect to Tabbar
      ),
      translations: LocaleString(),
      locale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute:
          // box.hasData('name') ? Routes.HOME :
          Routes.LOGIN,
      getPages: AppPages.routes,
    ),
  );
}
