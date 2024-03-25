import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AppFunctions {
  AppFunctions._();

  static Future<dynamic> showBtmSheet(
      {required bool isDismissible,
      required BuildContext context,
      required List<Widget> body}) {
    return showModalBottomSheet(
      useSafeArea: true,
      barrierColor: AppColors.mainColor.withOpacity(0.4),
      isScrollControlled: true,
      isDismissible: isDismissible,
      elevation: 10,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                shrinkWrap: true,
                children: body,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> showBtmSheetWithTextAndButton({
    required BuildContext context,
    required TextEditingController controller,
    required String title,
    required String lable,
    required String buttonText,
    required IconData sheetIcon,
    required IconData prefixIcon,
    required VoidCallback onPressedbutton,
    required VoidCallback onTapSheetIcon,
    VoidCallback? suffixIconFunction,
    bool obscureText = false,
    bool suffixIconShow = false,
  }) async {
    AppFunctions.showBtmSheet(
      isDismissible: false,
      context: context,
      body: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              color: AppColors.mainColor,
            ),
            InkWell(
              onTap: onTapSheetIcon,
              child: Icon(
                sheetIcon,
                color: AppColors.mainColor,
                size: 30,
              ),
            )
          ],
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          obscureText: obscureText,
          suffixIconShow: suffixIconShow,
          suffixIconFunction: suffixIconFunction,
          label: lable,
          maxLength: 50,
          controller: controller,
          keyBoard: TextInputType.emailAddress,
          prefixIcon: prefixIcon,
          filled: AppColors.kGrey200,
        ),
        SizedBox(height: 10.h),
        CustomButton(
          onPressed: onPressedbutton,
          text: buttonText,
          width: double.infinity,
          height: 45,
          threeRadius: 10,
          lastRadius: 10,
          backgroundColor: AppColors.mainColor,
          textColor: AppColors.kWhite,
        ),
        // SizedBox(height: Platform.isIOS ? 0.h : 0.h),
      ],
    );
  }

  static Future<void> permissionsDialog() {
    return Get.dialog(CupertinoAlertDialog(
      title: const Text('Permissions Denied'),
      content: const Text('Allow access to gallery and photos'),
      actions: [
        CupertinoDialogAction(
          child: const CustomText(text: 'cancel'),
          onPressed: () => Get.back(),
        ),
        const CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: openAppSettings,
          child: Text('Settings'),
        )
      ],
    ));
  }
}
