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
      body: Obx(() => screens[controller.currentSelected.value]),
    );
  }
}
