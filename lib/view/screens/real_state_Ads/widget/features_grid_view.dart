import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ad_info_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ad_info_cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/media_query_value.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../bloc/add_real_ads/cubit.dart';
import '../../../../bloc/add_real_ads/state.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/text_style.dart';

class CustomGridFeature extends StatelessWidget {
  const CustomGridFeature({super.key});

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit = context.read<AddRealAdsCubit>();
    return BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
      builder: (context, state) {
        return MasonryGridView.count(
          itemCount: addRealAdsCubit.additionalFeatureModel.data!.length,
          scrollDirection: Axis.horizontal,
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   mainAxisExtent: context.width * 0.21.sp,
          //   mainAxisSpacing: context.width * 0.02.sp,
          //   crossAxisCount: 1,
          //   childAspectRatio: 16 / 13,
          // ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                addRealAdsCubit.chooseFeatures(index: index);
              },
              child: Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_LARGE.sp)),
                color: darkGreyColor,
                child: Container(
                    padding: EdgeInsets.all(8.sp),
                    height: context.height * 0.06.sp,
                    width: context.width * 0.25.sp,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_LARGE),
                        // color:  addRealAdsCubit.resourceCreateModel.type![index].istabbed
                        //     ? lightGrey
                        //     : whiteColor
                        color: addRealAdsCubit.additionalFeatureModel
                                    .data![index].isTabbed ==
                                true
                            ? lightGrey
                            : whiteColor),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      alignment: AlignmentDirectional.centerStart,
                      child: Row(
                        //  mainAxisSize: MainAxisSize.max,
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            addRealAdsCubit
                                .additionalFeatureModel.data![index].image!,
                            height: 35.sp,
                            width: 35.sp,
                          ),
                          SizedBox(
                            width: 5.sp,
                          ),
                          AutoSizeText(
                            addRealAdsCubit
                                .additionalFeatureModel.data![index].name!,
                            style: openSansRegular.copyWith(
                                color: darkGreyColor, fontSize: 25.sp),
                            presetFontSizes: [25.sp, 20.sp, 18.sp],
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    )),
              ),
            );
          },
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 10.sp,
        );
      },
    );
  }
}

class CustomGridFeatureForEdit extends StatelessWidget {
  const CustomGridFeatureForEdit({super.key});

  @override
  Widget build(BuildContext context) {
    var editAdCubit = context.read<EditAdInfoCubit>();
    return BlocBuilder<EditAdInfoCubit, EditAdInfoState>(
      builder: (context, state) {
        return  MultiSelectDialogField(
          // listType: MultiSelectListType.CHIP,

          title: Text(
            LocaleKeys.features.tr(),
            style:
            openSansBold.copyWith(color: darkGreyColor),
          ),
          buttonText: Text(
            LocaleKeys.features.tr(),
            style:
            openSansMedium.copyWith(color: darkGreyColor),
          ),
          searchTextStyle:
          openSansMedium.copyWith(color: darkGreyColor),
          searchable: true,
          searchHintStyle:
          openSansMedium.copyWith(color: darkGreyColor),
          searchHint: LocaleKeys.search.tr(),
          selectedItemsTextStyle:
          openSansMedium.copyWith(color: darkGreyColor),
          unselectedColor: darkGreyColor,
          buttonIcon: Icon(
            Icons.arrow_drop_down_outlined,
            color: darkGreyColor,
          ),
          selectedColor: goldColor.withOpacity(0.1),
          checkColor: goldColor,
          itemsTextStyle: openSansRegular,
          decoration: BoxDecoration(
              border: Border.all(color: darkGreyColor),
              borderRadius: BorderRadius.circular(
                  Dimensions.RADIUS_DEFAULT)),
          initialValue: editAdCubit.featuresSameId,

          items: editAdCubit.additionalFeatureModel.data!.map((e) {
            return MultiSelectItem(e.id, e.name ?? '');
          }).toList(),
          //     registerProviderCubit.mainServices.map((e) {
          //   return MultiSelectItem(e['name'], e['name']);
          // }).toList(),
          onConfirm: (val) {
            debugPrint('################${val.toString()}');
            editAdCubit.onUpdateFeaturesAds(val);
            //   registerProviderCubit.getSubServicesById();
            // print(
            //     '${registerProviderCubit.interestsList} ///////////////////////////////////');
          },
        );

      },
    );
  }
}
///
// return MasonryGridView.count(
//   itemCount: editAdCubit.additionalFeatureModel.data!.length,
//   scrollDirection: Axis.horizontal,
//   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   //   mainAxisExtent: context.width * 0.21.sp,
//   //   mainAxisSpacing: context.width * 0.02.sp,
//   //   crossAxisCount: 1,
//   //   childAspectRatio: 16 / 13,
//   // ),
//   itemBuilder: (context, index) {
//     return GestureDetector(
//       onTap: () {
//         editAdCubit.chooseFeaturesForEdit(index: index);
//       },
//       child: Card(
//         elevation: 0.5,
//         shape: RoundedRectangleBorder(
//             borderRadius:
//             BorderRadius.circular(Dimensions.RADIUS_LARGE.sp)),
//         color: darkGreyColor,
//         child: Container(
//             padding: EdgeInsets.all(8.sp),
//             height: context.height * 0.06.sp,
//             width: context.width * 0.25.sp,
//             decoration: BoxDecoration(
//                 borderRadius:
//                 BorderRadius.circular(Dimensions.RADIUS_LARGE),
//                 // color:  addRealAdsCubit.resourceCreateModel.type![index].istabbed
//                 //     ? lightGrey
//                 //     : whiteColor
//                 color: editAdCubit.additionalFeatureModel.data![index].isTabbed == true ||
//                     editAdCubit.featuresSameId[index]==editAdCubit.additionalFeatureModel.data![index].id
//                     ? lightGrey
//                     : whiteColor),
//             child: FittedBox(
//               fit: BoxFit.contain,
//               alignment: AlignmentDirectional.centerStart,
//               child: Row(
//                 //  mainAxisSize: MainAxisSize.max,
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Image.network(
//                     editAdCubit
//                         .additionalFeatureModel.data![index].image!,
//                     height: 35.sp,
//                     width: 35.sp,
//                   ),
//                   SizedBox(
//                     width: 5.sp,
//                   ),
//                   AutoSizeText(
//                     editAdCubit
//                         .additionalFeatureModel.data![index].name!,
//                     style: openSansRegular.copyWith(
//                         color: darkGreyColor, fontSize: 25.sp),
//                     presetFontSizes: [25.sp, 20.sp, 18.sp],
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: true,
//                     maxLines: 1,
//                   ),
//                 ],
//               ),
//             )),
//       ),
//     );
//   },
//   crossAxisCount: 2,
//   mainAxisSpacing: 2,
//   crossAxisSpacing: 10.sp,
// );