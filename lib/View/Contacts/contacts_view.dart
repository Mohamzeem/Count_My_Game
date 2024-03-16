import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Contacts/controller/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsView extends GetWidget<ContactsController> {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Center(
          child: CustomText(text: 'ContactsView'),
        ),
      ],
    );
  }
}
