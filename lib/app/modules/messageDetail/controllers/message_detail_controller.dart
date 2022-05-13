import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MessageDetailController extends GetxController {
  //TODO: Implement MessageDetailController

  final checked = false.obs;
  var selectedContacts = [].obs;
  var selectedCopy = [].obs;
  var selectedcount = 0.obs;
  List<Contact> allContacts = <Contact>[].obs;

  RxList<bool> selected = <bool>[].obs;
  RxList<Contact> contactsFiltered = <Contact>[].obs;

  RxString title = "MyTitle".obs;
  RxBool isEditable = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  onClose() {}

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      allContacts = await FastContacts.allContacts;
      return allContacts;
    }

    return [];
  }
}
