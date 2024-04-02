import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/pick_friends_item.dart';
import 'package:count_my_game/View_Model/friends_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';

class PickFriendsIcon extends StatelessWidget {
  const PickFriendsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsController>(
      builder: (controller) => InkWell(
        onTap: () {
          AppFunctions.showBtmSheet(
            isDismissible: true,
            context: context,
            body: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 400.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                            color: AppColors.mainColor,
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                              controller.fromFriends = !controller.fromFriends;
                            },
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back,
                                size: 25,
                                color: AppColors.kWhite,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        const CustomText(
                          text: 'Pick friend to add team',
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.frinedsList.length,
                        itemBuilder: (context, index) {
                          final friendModel = controller.frinedsList[index];
                          return PickFriendsItem(
                            name: friendModel.name!,
                            photoUrl: friendModel.isPhoto,
                            onTap: () {
                              controller.friendTwo = friendModel;
                              Get.back();
                            },
                          );
                        },
                      ),
                    ),
                    // StreamBuilder(
                    //   stream: controller.getFriends(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       final List<FriendModel> frinedsList = snapshot.data!;
                    //       if (frinedsList.isEmpty || frinedsList == []) {
                    //         return const Center(
                    //           child: CustomText(
                    //             text: 'No Friends Found !!!',
                    //             color: AppColors.mainColor,
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: 25,
                    //           ),
                    //         );
                    //       } else {
                    //         return Expanded(
                    //           child: ListView.builder(
                    //             itemCount: frinedsList.length,
                    //             itemBuilder: (context, index) {
                    //               final friendModel = frinedsList[index];
                    //               return FriendsItem(
                    //                 name: friendModel.name!,
                    //                 photoUrl: friendModel.isPhoto,
                    //                 onDismissed: (direction) {
                    //                   if (teamNum == '2') {
                    //                     // controller.friendTwo = friendModel;
                    //                     Get.back();
                    //                   }
                    //                   if (teamNum == '3') {
                    //                     // controller.friendThree = friendModel;
                    //                     controller.fromFriends =
                    //                         !controller.fromFriends;
                    //                     Get.back();
                    //                   }
                    //                 },
                    //               );
                    //             },
                    //           ),
                    //         );
                    //       }
                    //     } else if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return Center(
                    //         child: CustomCircularLoading(
                    //             height: 50.h, width: 50.w),
                    //       );
                    //     } else if (snapshot.hasError) {
                    //       return const Center(
                    //         child: CustomText(
                    //           text: "Something went wrong !!!",
                    //           color: AppColors.mainColor,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 25,
                    //         ),
                    //       );
                    //     } else if (!snapshot.hasData) {
                    //       return const Center(
                    //         child: CustomText(
                    //           text: 'No Friends Found !!!',
                    //           color: AppColors.mainColor,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 25,
                    //         ),
                    //       );
                    //     } else {
                    //       return const Center(
                    //         child: CustomCircularLoading(height: 50, width: 50),
                    //       );
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          );

          print('1 ${controller.fromFriends}');
          // controller.fromFriends = !controller.fromFriends;

          if (controller.fromFriends == false) {
            controller.fromFriends = true;
          }

          // controller.fromFriends = !controller.fromFriends;
          print('2 ${controller.fromFriends}');
        },
        child: Container(
          height: 40.h,
          width: 28.w,
          decoration: const BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: const Icon(
            Icons.person_2,
            color: AppColors.kWhite,
            size: 25,
          ),
        ),
      ),
    );
  }
}
