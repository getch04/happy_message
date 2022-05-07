import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happy_messanger/app/modules/contacts/views/contacts_view.dart';
import 'package:happy_messanger/app/modules/home/views/fancy_tabBar.dart';
import 'package:happy_messanger/app/modules/mainHome/views/main_home_view.dart';
import 'package:happy_messanger/app/modules/message/views/message_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  var controller = Get.put(HomeController());

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  var screens = [ContactsView(), MainHomeView(), MessageView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: FancyTabBar(),

      // Obx(
      //   () => Theme(
      //     data: Theme.of(context).copyWith(
      //         // iconTheme: IconThemeData(color: Colors.green),
      //         ),
      //     child: CurvedNavigationBar(
      //       key: _bottomNavigationKey,
      //       index: controller.page.value,
      //       height: 60.0,
      //       items: const <Widget>[
      //         Icon(Icons.home_outlined, size: 30),
      //         Icon(Icons.contacts_outlined, size: 30),
      //         Icon(Icons.message_outlined, size: 30),
      //       ],
      //       color: Colors.white,
      //       buttonBackgroundColor: Colors.white,
      //       backgroundColor: Colors.transparent,
      //       animationCurve: Curves.easeInOut,
      //       animationDuration: const Duration(milliseconds: 300),
      //       onTap: (index) {
      //         controller.page.value = index;
      //       },
      //       letIndexChange: (index) => true,
      //     ),
      //   ),
      // ),

      body: Obx(() => screens[controller.currentSelected.value]),
    );
  }
}
