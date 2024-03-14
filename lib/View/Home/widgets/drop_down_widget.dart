import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View_Model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DropDownWidget extends GetWidget<HomeController> {
  const DropDownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 120,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.mainColor, width: 2),
        ),
        child: Center(
          child: DropdownButton<String>(
            iconEnabledColor: Colors.grey,
            style: const TextStyle(color: AppColors.mainColor, fontSize: 20),
            elevation: 10,
            alignment: Alignment.center,
            dropdownColor: AppColors.kWhite,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            hint: const Text('Number'),
            onChanged: (value) => controller.dropDownValue(value!),
            value: controller.selected.value == ''
                ? null
                : controller.selected.value,
            items: controller.numList.map((number) {
              return DropdownMenuItem(
                value: number,
                alignment: Alignment.center,
                child: Text(number),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
