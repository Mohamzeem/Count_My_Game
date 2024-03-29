import 'package:cached_network_image/cached_network_image.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Widgets/custom_circular_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCachedImage extends StatelessWidget {
  final String photoUrl;
  final Widget? child;
  final double? width;
  final double? height;
  final BoxShape shape;
  const CustomCachedImage({
    super.key,
    required this.photoUrl,
    this.child = const SizedBox.shrink(),
    this.width = 40,
    this.height = 40,
    this.shape = BoxShape.circle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        progressIndicatorBuilder: (context, url, progress) =>
            const CustomCircularLoading(height: 30, width: 30),
        imageUrl: photoUrl.isEmpty || photoUrl == ''
            ? AppStrings.defaultAppPhoto
            : photoUrl,
        fit: BoxFit.fill,
        imageBuilder: (context, imageProvider) => Container(
          width: width!.w,
          height: height!.h,
          decoration: BoxDecoration(
            shape: shape,
            // color: AppColors.mainColor,
            // border: Border.all(width: 0.5, color: AppColors.mainColor,),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
          child: child,
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          size: 40,
          color: AppColors.kRed,
        ),
      ),
    );
  }
}
