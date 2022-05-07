import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/contacts_controller.dart';

class ContactsView extends GetView<ContactsController> {
  @override
  var controller = Get.put(ContactsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contact List"),
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: double.infinity,
        child: FutureBuilder(
          future: controller.getContacts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: SizedBox(height: 50, child: CircularProgressIndicator()),
              );
            } else {
              var heyy = [];
              for (var item in snapshot.data) {
                if (item.displayName != '' && item.phones.isNotEmpty) {
                  heyy.add(item);
                }
              }
              return ListView.builder(
                itemCount: heyy.length,
                itemBuilder: (context, index) {
                  Contact contact = heyy[index];

                  return Column(
                    children: [
                      ListTile(
                        dense: true,
                        leading: const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                        title: Text(contact.displayName == ''
                            ? ''
                            : contact.displayName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            contact.phones.isEmpty
                                ? const Text('')
                                : Text(contact.phones[0])
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
