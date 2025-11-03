// import 'package:flutter/material.dart';
//
// import '../../../../utils/dimention.dart';
// import '../../../../utils/images.dart';
// import '../../../../utils/text_style.dart';
//
// class HorizontalImageList extends StatelessWidget {
//   const HorizontalImageList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 110,
//       child: ListView.separated(
//
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             return Container(
//               height: 100,
//               width: 120,
//               decoration: BoxDecoration(
//                   borderRadius:
//                   BorderRadius.circular(Dimensions.RADIUS_LARGE),
//                   border: Border.all(color: goldColor)),
//               child: ClipRRect(
//                 borderRadius:
//                 BorderRadius.circular(Dimensions.RADIUS_LARGE),
//                 child: Image.asset(
//                   Images.SERVICES_DEVELOPMENT,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             );
//           },
//           separatorBuilder: (context, index) {
//             return SizedBox(
//               width: Dimensions.PADDING_SIZE_SMALL,
//             );
//           },
//           itemCount: 2),
//     );
//   }
// }
