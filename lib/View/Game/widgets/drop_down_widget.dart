import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View_Model/game_controller.dart';

class DropDownWidget extends GetWidget<GameController> {
  final bool isGameName;

  const DropDownWidget({
    super.key,
    required this.isGameName,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 140,
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
            hint: Text(isGameName ? 'Game' : 'Number'),
            onChanged: isGameName
                ? (value) => controller.dropDownValueGamesList(value!)
                : (value) => controller.dropDownValueNumList(value!),
            value: isGameName
                ? controller.selectedGame.value == ''
                    ? null
                    : controller.selectedGame.value
                : controller.selectedNum.value == ''
                    ? null
                    : controller.selectedNum.value,
            items: isGameName
                ? controller.gamesList.map((game) {
                    return DropdownMenuItem(
                      value: game,
                      alignment: Alignment.center,
                      child: Text(game),
                    );
                  }).toList()
                : controller.numList.map((number) {
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
