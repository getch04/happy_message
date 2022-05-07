import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_home_controller.dart';

class MainHomeView extends GetView<MainHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
          title: const Text('MainHomeView'),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: const Center(
        child: const Text(
          'MainHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
