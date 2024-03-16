import 'package:count_my_game/Core/App/app_info.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Profile/widgets/profile_item.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildVerison extends GetWidget<AuthController> {
  const BuildVerison({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
      onTap: () {
        // debugPrint('1 ${controller.newName}');
        // debugPrint('2 ${controller.userModel.value.id}');
        debugPrint('1 ${controller.offlineProfile.name}');
        debugPrint('2 ${controller.offlineProfile.id}');
        debugPrint('3 ${FirebaseAuth.instance.currentUser!.photoURL}');
      },
      icon: Icons.verified_user_outlined,
      mainText: 'Build Verison',
      suppText: '',
      withGoIcon: false,
      widget: FutureBuilder<String>(
        future: AppInfoUtil().getAppVersion(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomText(
              text: snapshot.data.toString(),
              fontSize: 18,
              color: AppColors.kGrey200,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
