import 'package:count_my_game/View/Home/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: HomeBody(),
      ),
    );

    // return Scaffold(
    //   appBar: (AppBar(
    //     centerTitle: true,
    //     title: const CWText(
    //         text: 'Points Counter',
    //         fontSize: 30,
    //         color: Colors.black,
    //         fontWeight: FontWeight.w700,
    //         textAlign: TextAlign.center),
    //     backgroundColor: Colors.orange,
    //   )),
    //   body: SingleChildScrollView(
    //     child: BlocConsumer<CounterCubit, CounterState>(
    //       builder: ((context, state) {
    //         return Column(
    //           children: [
    //             SizedBox(
    //               height: 20.h,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 SizedBox(
    //                   height: MediaQuery.of(context).size.height * 0.43,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       const CWText(
    //                           text: 'Team A',
    //                           fontSize: 35,
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.w500,
    //                           textAlign: TextAlign.center),
    //                       Container(
    //                         width: 150.w,
    //                         height: 95.h,
    //                         decoration: BoxDecoration(
    //                             color: Colors.orange.shade200,
    //                             borderRadius: BorderRadius.circular(18)),
    //                         child: CWText(
    //                             text:
    //                                 '${BlocProvider.of<CounterCubit>(context).teamAPoints}',
    //                             fontSize: 85,
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.w500,
    //                             textAlign: TextAlign.center),
    //                       ),
    //                       CWElevatedButton(
    //                         name: 'Reset Team Points',
    //                         onPressed: () {
    //                           BlocProvider.of<CounterCubit>(context)
    //                               .teamReset(team: 'A');
    //                           controller.clear();
    //                         },
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.w500,
    //                         fontSize: 14,
    //                         backgroundColor: Colors.black,
    //                       ),
    //                       CWElevatedButton(
    //                         name: 'Add Points',
    //                         onPressed: () {
    //                           BlocProvider.of<CounterCubit>(context)
    //                               .teamIncrement(
    //                                   team: 'A',
    //                                   number: int.parse(controller.text));
    //                           controller.clear();
    //                         },
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.w700,
    //                         fontSize: 20,
    //                         backgroundColor: Colors.orange,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: MediaQuery.of(context).size.height * 0.43,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       const CWText(
    //                           text: 'Team B',
    //                           fontSize: 35,
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.w500,
    //                           textAlign: TextAlign.center),
    //                       Container(
    //                         width: 150.w,
    //                         height: 95.h,
    //                         decoration: BoxDecoration(
    //                             color: Colors.orange.shade200,
    //                             borderRadius: BorderRadius.circular(18)),
    //                         child: CWText(
    //                             text:
    //                                 '${BlocProvider.of<CounterCubit>(context).teamBPoints}',
    //                             fontSize: 85,
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.w500,
    //                             textAlign: TextAlign.center),
    //                       ),
    //                       CWElevatedButton(
    //                         name: 'Reset Team Points',
    //                         onPressed: () {
    //                           BlocProvider.of<CounterCubit>(context)
    //                               .teamReset(team: 'B');
    //                           controller.clear();
    //                         },
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.w500,
    //                         fontSize: 14,
    //                         backgroundColor: Colors.black,
    //                       ),
    //                       CWElevatedButton(
    //                         name: 'Add Points',
    //                         onPressed: () {
    //                           BlocProvider.of<CounterCubit>(context)
    //                               .teamIncrement(
    //                                   team: 'B',
    //                                   number: int.parse(controller.text));
    //                           controller.clear();
    //                         },
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.w700,
    //                         fontSize: 20,
    //                         backgroundColor: Colors.orange,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 const CWText(
    //                     text: 'Add Number',
    //                     fontSize: 30,
    //                     color: Colors.black,
    //                     fontWeight: FontWeight.w500,
    //                     textAlign: TextAlign.end),
    //                 CWTextFormField(
    //                   controller: controller,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         );
    //       }),
    //       listener: ((context, state) {}),
    //     ),
    //   ),
    // );
  }
}
