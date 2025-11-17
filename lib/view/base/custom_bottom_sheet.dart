import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/region_cubit/cubit.dart';
import '../../bloc/region_cubit/state.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/dimention.dart';
import '../../utils/media_query_value.dart';
import '../../utils/text_style.dart';
import '../../view/base/pagination_view.dart';
import 'adaptive_dialog_loader.dart';
import 'main_button.dart';

Future CustomBottomSheet(
    {required BuildContext context,
    required ScrollController controller,
    required Function confirm,
    int? regionFilter}) {
  var regionCubit = context.read<RegionsCubit>();
  return showModalBottomSheet(
      context: context,
      builder: (c) {
        return BlocConsumer<RegionsCubit, RegionState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return StatefulBuilder(builder: (context, StateSetter setState) {
              return Container(
                  height: context.height * 0.75,
                  child: regionCubit.isGetCities == false
                      ? adaptiveCircleProgress()
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: controller,
                                    child: PaginatedListView(
                                        last: regionCubit.cityByRegionIdModel
                                            .meta!.lastPage!,
                                        offset: regionCubit.cityByRegionIdModel
                                            .meta!.currentPage!,
                                        onPaginate: (int offset) async {
                                          print(offset);
                                          await regionCubit.getCitiesByRegionId(
                                            page: offset,
                                            context: context,
                                            regionId: regionFilter ??
                                                regionCubit.regionId!,
                                          );
                                        },
                                        scrollController: controller,
                                        totalSize: regionCubit
                                                .cityByRegionIdModel.meta?.to ??
                                            15,
                                        //  reverse: true,
                                        enabledPagination: true,
                                        productView: ListView.builder(
                                            itemCount: regionCubit
                                                .cityByRegionIdModel
                                                .data!
                                                .length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsetsDirectional.only(
                                                bottom: Dimensions
                                                        .PADDING_SIZE_OVER_LARGE *
                                                    1.65.sp),
                                            //  controller: _scrollController,
                                            itemBuilder: (context, index) {
                                              return CheckboxListTile(
                                                  title: Text(regionCubit
                                                          .cityByRegionIdModel
                                                          .data![index]
                                                          .name ??
                                                      ''),
                                                  activeColor: goldColor,
                                                  value: regionCubit
                                                      .cityByRegionIdModel
                                                      .data![index]
                                                      .istabbed,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      // regionCubit.cityByRegionIdModel.data![index].istabbed =
                                                      //     val;
                                                      regionCubit.onChangeCity(
                                                          i: index, val: val!);
                                                      print(val);
                                                    });
                                                  });
                                            })),
                                  ),
                                ),
                              ],
                            ),
                            regionCubit.cities.isEmpty &&
                                    regionCubit.cityByRegionIdModel.data![0]
                                            .istabbed ==
                                        false
                                ? SizedBox()
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      // SizedBox(
                                      // height: Dimensions.PADDING_SIZE_OVER_LARGE*1.5.sp,
                                      // )
                                      padding: EdgeInsetsDirectional.only(
                                          bottom: Dimensions
                                                  .PADDING_SIZE_OVER_LARGE *
                                              3.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomButton(
                                              width: context.width * 0.4,
                                              color: darkGreyColor,
                                              textButton:
                                                  LocaleKeys.confirm.tr(),
                                              onPressed: () {
                                                confirm();
                                              }),
                                          SizedBox(
                                            width: context.width * 0.03,
                                          ),
                                          CustomButton(
                                            textButton: LocaleKeys.clear.tr(),
                                            onPressed: () {
                                              regionCubit.clearCitiesList();
                                            },
                                            width: context.width * 0.4,
                                            color: redColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                          ],
                        ));
            });
          },
        );
      });
}
