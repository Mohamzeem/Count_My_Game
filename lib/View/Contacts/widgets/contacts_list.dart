import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_circular_loading.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Models/user_friend.dart';
import 'package:count_my_game/View/Contacts/widgets/contacts_item.dart';
import 'package:count_my_game/View_Model/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactsController>(
      builder: (controller) => StreamBuilder(
        stream: controller.getFriends(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<FriendModel> frinedsList = snapshot.data!;

            if (frinedsList.isEmpty || frinedsList == []) {
              return Padding(
                padding: EdgeInsets.only(top: 300.h),
                child: const CustomText(
                  text: 'No Friends Found !!!',
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              );
            } else {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: ListView.builder(
                    itemCount: frinedsList.length,
                    itemBuilder: (context, index) {
                      final friendModel = frinedsList[index];
                      return ContactsItem(
                        name: friendModel.name!,
                        photoUrl: friendModel.isPhoto,
                        onTap: () {
                          controller.deleteFriend(
                              id: friendModel.id!, name: friendModel.name!);
                          print(friendModel.id);
                        },
                      );
                    },
                  ),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: CustomCircularLoading(height: 50.h, width: 50.w),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: const CustomText(
                text: "Something went wrong !!!",
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            );
          } else if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: const CustomText(
                text: 'No Friends Found !!!',
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: const CustomCircularLoading(height: 50, width: 50),
            );
          }
        },
      ),
    );
  }
}
