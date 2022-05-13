import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happy_messanger/app/modules/mainHome/views/birthday_view.dart';
import 'package:happy_messanger/constants/colors.dart';

import '../controllers/main_home_controller.dart';

class MainHomeView extends GetView<MainHomeController> {
  var controller = Get.put(MainHomeController());

  final style = const TextStyle(
    // color: Colors.black,
    fontSize: 20,
    fontFamily: 'AkayaTelivigala',
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFAF8),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150.0),
          child: AppBar(
            actions: [
              Obx(
                () => TextButton(
                  onPressed: () {
                    controller.isAmharic.value = !controller.isAmharic.value;
                    if (controller.isAmharic.value == true) {
                      controller.box.write('lang', 'አማርኛ');
                      controller.langCtrl.changeLocale('አማርኛ');
                    } else if (controller.isAmharic.value == false) {
                      controller.box.write('lang', 'English');
                      controller.langCtrl.changeLocale('English');
                    }
                  },
                  child: Text(
                    controller.isAmharic.value ? 'አማ' : 'EN',
                    style: style,
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              indicatorColor: const Color(0xFF8c77ec),
              labelColor: const Color(0xFF8c77ec),
              unselectedLabelColor: Colors.grey,
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              labelStyle: style,
              tabs: [
                Tab(icon: const Icon(Icons.event), text: 'events'.tr),
                Tab(icon: const Icon(Icons.celebration), text: 'holiday'.tr),
                Tab(icon: const Icon(Icons.cake), text: 'birthday'.tr),
                Tab(icon: const Icon(Icons.school), text: 'graduation'.tr),
              ],
            ),
            title: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  Text(
                    'Home',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 22,
                      fontFamily: 'AkayaTelivigala',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            SizedBox(
              child: Text('events'),
            ),
            BirthdayView(),
            BirthdayView(),
            SizedBox(
              child: Text('graduation'),
            ),
          ],
        ),
      ),
    );
  }
}
