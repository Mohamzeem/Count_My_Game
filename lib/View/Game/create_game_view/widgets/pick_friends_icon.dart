// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'package:count_my_game/Core/Utils/app_colors.dart';
// import 'package:count_my_game/Core/Utils/functions.dart';
// import 'package:count_my_game/Core/Widgets/custom_text.dart';
// import 'package:count_my_game/Models/team_model.dart';
// import 'package:count_my_game/View/Game/create_game_view/widgets/pick_friends_item.dart';
// import 'package:count_my_game/View_Model/friends_controller.dart';
// import 'package:count_my_game/View_Model/game_controller.dart';

// class PickFriendsIcon extends StatefulWidget {
//   final String teamModelPicked;
//   const PickFriendsIcon({
//     super.key,
//     required this.teamModelPicked,
//   });

//   @override
//   State<PickFriendsIcon> createState() => _PickFriendsIconState();
// }

// class _PickFriendsIconState extends State<PickFriendsIcon> {
//   final frinedsCont = Get.put(FriendsController());
//   final gameCont = Get.put(GameController());
//   @override
//   void initState() {
//     super.initState();
//     frinedsCont.getFriendsForPick();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FriendsController>(
//       builder: (controller) => InkWell(
//         onTap: () {
//           AppFunctions.showBtmSheet(
//             isDismissible: true,
//             context: context,
//             body: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 height: 400.h,
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           height: 40.h,
//                           width: 40.w,
//                           decoration: const BoxDecoration(
//                             color: AppColors.mainColor,
//                             shape: BoxShape.circle,
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               Get.back();
//                               // if (gameCont.selectedNum.value == '2') {
//                               //   controller.fromFriendsTeamTwo =
//                               //       !controller.fromFriendsTeamTwo;
//                               // } else if (gameCont.selectedNum.value == '3') {}
//                             },
//                             child: const Center(
//                               child: Icon(
//                                 Icons.arrow_back,
//                                 size: 25,
//                                 color: AppColors.kWhite,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 20.w),
//                         const CustomText(
//                           text: 'Pick friend to add team',
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.mainColor,
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: controller.frinedsList.length,
//                         itemBuilder: (context, index) {
//                           final friendModel = controller.frinedsList[index];
//                           return GetBuilder<GameController>(
//                             builder: (gameCont) => PickFriendsItem(
//                               name: friendModel.name!,
//                               photoUrl: friendModel.isPhoto,
//                               onTap: () {
//                                 TeamModel teamModel = TeamModel(
//                                   id: friendModel.id,
//                                   name: friendModel.name,
//                                   photo: friendModel.isPhoto,
//                                 );
//                                 if (widget.teamModelPicked == '2') {
//                                   gameCont.teamTwo = teamModel;
//                                 }
//                                 if (widget.teamModelPicked == '3') {
//                                   gameCont.teamThree = teamModel;
//                                 }
//                                 if (widget.teamModelPicked == '4') {
//                                   gameCont.teamFour = teamModel;
//                                 }
//                                 Get.back();
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//           if (controller.fromFriendsTeamTwo == false) {
//             controller.fromFriendsTeamTwo = true;
//           } else if (controller.fromFriendsTeamThree == false) {
//             controller.fromFriendsTeamThree = true;
//           } else if (controller.fromFriendsTeamFour == false) {
//             controller.fromFriendsTeamFour = true;
//           }
//         },
//         child: Container(
//           height: 40.h,
//           width: 28.w,
//           decoration: const BoxDecoration(
//             color: AppColors.mainColor,
//             borderRadius: BorderRadius.all(Radius.circular(5)),
//           ),
//           child: const Icon(
//             Icons.person_2,
//             color: AppColors.kWhite,
//             size: 25,
//           ),
//         ),
//       ),
//     );
//   }
// }
