import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';

class GameTeamsItem extends StatelessWidget {
  final bool isUser;
  final String teamName;
  final String score;
  final String photoUrl;
  final VoidCallback onTap;
  final VoidCallback doubleTap;
  final bool isTwoTeams;
  const GameTeamsItem({
    super.key,
    this.isUser = false,
    required this.teamName,
    required this.score,
    required this.photoUrl,
    required this.onTap,
    required this.doubleTap,
    this.isTwoTeams = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: doubleTap,
      child: Card(
        elevation: 10,
        surfaceTintColor: AppColors.kBackGround,
        child: Column(
          children: [
            //^ team name
            Padding(
              padding: EdgeInsets.all(5.r),
              child: CustomText(
                text: teamName,
                color: AppColors.kBlack,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            //^ photo
            Container(
              width: isTwoTeams ? 350.w : 180.w,
              height: 100.h,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: isUser
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isTwoTeams ? 20.w : 10.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomCachedImage(
                          shape: BoxShape.rectangle,
                          photoUrl: photoUrl,
                          height: 170,
                          width: 100,
                        ),
                      ),
                    )
                  : photoUrl.contains('firebasestorage')
                      //^ image from firebase
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isTwoTeams ? 20.w : 10.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomCachedImage(
                              shape: BoxShape.rectangle,
                              photoUrl: photoUrl,
                              height: 170,
                              width: 100,
                            ),
                          ),
                        )
                      //^ image from local
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isTwoTeams ? 20.w : 10.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle),
                              width: 185,
                              height: 100,
                              child: Image.memory(
                                base64Decode(photoUrl),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
            ),
            //^ score
            Padding(
              padding: EdgeInsets.all(5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Score: ',
                    color: AppColors.kBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: score,
                    color: AppColors.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
