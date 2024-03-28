import 'package:count_my_game/Core/Widgets/custom_app_bar.dart';
import 'package:count_my_game/View/Contacts/widgets/contacts_list.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactsBody extends StatelessWidget {
  const ContactsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          //^ appbar
          GetBuilder<AuthController>(
            builder: (controller) => CustomAppBar(
              title: ' ${controller.offlineProfile.name!}',
              photoUrl: controller.offlineProfile.isPhoto,
              isArrowBack: false,
            ),
          ),
          const ContactsList(),
        ],
      ),
    );
  }
}
