// import 'package:aqarat_raqamia/model/static_model/area_model.dart';
// import 'package:aqarat_raqamia/utils/text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../bloc/filter_search_add_cubit/cubit.dart';
// import '../../../../bloc/filter_search_add_cubit/state.dart';
// import '../../../../utils/dimention.dart';
//
// class AreaGridViewFilter extends StatelessWidget {
//   // String? selectedArea;
//   // AreaGridViewFilter({required this.selectedArea});
//   @override
//   Widget build(BuildContext context) {
//    var filterSearchAdsCubit= FilterSearchAdsCubit.get(context);
//     return BlocConsumer<FilterSearchAdsCubit, FilterSearchAdsState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         return Container(
//           height: 150.h,
//           child: GridView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: areaModel.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 16 / 9,
//                   //  mainAxisExtent: Dimensions.PADDING_SIZE_LARGE,
//                   crossAxisCount: 3),
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {
//                     filterSearchAdsCubit.changeAreaStatus(index: index);
//                     print(areaModel[index].title);
//                     // selectedArea=areaModel[index].title;
//                     // print(selectedArea);
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius:
//                         BorderRadius.circular(Dimensions.RADIUS_LARGE)),
//                     child: Container(
//                       // height: 40.h,
//                       // width: 50.w,
//                       decoration: BoxDecoration(
//                           color:
//                           areaModel[index].isTabbed ? lightGrey : whiteColor,
//                           borderRadius:
//                           BorderRadius.circular(Dimensions.RADIUS_LARGE)),
//                       child: Center(
//                           child: Text(
//                             areaModel[index].title,
//                             style: openSansMedium.copyWith(
//                                 color: darkGreyColor),
//                           )),
//                     ),
//                   ),
//                 );
//               }),
//         );
//       },
//     );
//   }
// }
