// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:kepler/src/services/database/database.dart';
// import 'package:kepler/src/utils/cupertinoPageRoute.dart';
// import 'package:kepler/src/ui/views/charts/orbitChartView.dart';
// import 'package:kepler/src/ui/widgets/backgrounds/background.dart';
// import 'package:kepler/src/ui/widgets/cards/imageCard.dart';
// import 'package:kepler/src/ui/widgets/header/header.dart';

// class ChartsView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Background(),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           body: CustomScrollView(
//             slivers: [
//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) => Column(
//                     children: [
//                       Header('Charts', () => Navigator.of(context).pop()),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 16.0,
//                           right: 16.0,
//                           top: 8.0,
//                         ),
//                         child: ColorsCard(
//                           colorList: [Colors.blue[100], Colors.green[100]],
//                           text:
//                               "Orbit Size Ranking", //TODO - LOCALIZE - ORBIT SIZE RANKING
//                           onTap: () {
//                             // Navigator.of(context).push(
//                             //   route(
//                             //     OrbitChartView(
//                             //       "Orbit Size Ranking",
//                             //       KeplerDatabase.db.getAllPlanetsOrbits(),
//                             //     ),
//                             //   ),
//                             // );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   childCount: 1,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
