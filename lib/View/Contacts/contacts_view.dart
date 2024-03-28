import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/View/Contacts/widgets/contacts_body.dart';
import 'package:count_my_game/View_Model/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactsController>(
      init: ContactsController(),
      builder: (controller) => Scaffold(
        body: const SafeArea(
          child: ContactsBody(),
        ),
        //^ floating add btn
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            elevation: 5,
            backgroundColor: AppColors.mainColor,
            onPressed: () => AppFunctions.showBtmSheetWithTextAndButton(
              context: context,
              controller: controller.nameController,
              title: 'Enter email to add friend',
              lable: 'Email',
              buttonText: 'Add friend',
              sheetIcon: Icons.close,
              prefixIcon: Icons.person,
              onPressedbutton: () => controller.addFriend(),
              onTapSheetIcon: () => Get.back(),
            ),
            child:
                const Icon(Icons.person_add, color: AppColors.kWhite, size: 40),
          ),
        ),
      ),
    );
  }
}
