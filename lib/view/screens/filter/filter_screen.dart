import 'package:aqarat_raqamia/bloc/add_real_ads/cubit.dart';
import 'package:aqarat_raqamia/bloc/add_real_ads/state.dart';
import 'package:aqarat_raqamia/bloc/filter_search_add_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/filter_search_add_cubit/state.dart';
import 'package:aqarat_raqamia/utils/dimention.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/adaptive_dialog_loader.dart';
import 'package:aqarat_raqamia/view/base/category_header.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:aqarat_raqamia/view/screens/filter/widget/purpose_grid.dart';
import 'package:aqarat_raqamia/view/screens/location/ads_on_map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../translation/locale_keys.g.dart';
import '../../base/back_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/riyal_widget.dart';
import '../category/category_screen.dart';
import '../home/widget/horizontal_grid_view.dart';

//ignore: must_be_immutable
class FilterScreen extends StatefulWidget {
  // const FilterScreen({super.key});
  int? id;

  FilterScreen({this.id});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController areaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get.find<FilterController>();
    var filterSearchAdsCubit = context.read<FilterSearchAdsCubit>();
    var addRealAdsCubit = context.read<AddRealAdsCubit>();
    addRealAdsCubit.returnAdsTypeToDefault();
    addRealAdsCubit.returnPurposeStateToDefault();
    filterSearchAdsCubit.returnRangeValueDefault();
    return BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
      builder: (context, state) {
        if (state is GetFeatureForCreateAdsLoadingState) {
          return adaptiveCircleProgress();
        }
        return BlocBuilder<FilterSearchAdsCubit, FilterSearchAdsState>(
          builder: (context, state) {
            // RangeLabels labels = RangeLabels(
            //     filterSearchAdsCubit.values!.start.toString(),
            //     filterSearchAdsCubit.values!.end.toString());
            return Scaffold(
              appBar: CategoryHeader(
                  onTap: () {
                    areaController.clear();
                    filterSearchAdsCubit.returnRangeValueDefault();
                    addRealAdsCubit.returnAdsTypeToDefault();
                    addRealAdsCubit.returnPurposeStateToDefault();
                  },
                  title: LocaleKeys.searchForEstate.tr(),
                  leading: BackButtonWidget(
                    color: darkGreyColor,
                    foregroundColor: goldColor,
                  ),
                  action: Text(
                    LocaleKeys.clear.tr(),
                    style: openSansBlack.copyWith(color: redColor),
                  )),
              body: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.estateType.tr(),
                          style:
                              openSansExtraBold.copyWith(color: darkGreyColor),
                        ),
                        // HorizontalGridView(
                        //   isTabExtent: false,
                        // ),
                        HorizontalGridRealEstateType(
                          isTabExtent: false,
                        ),
                        Text(
                          LocaleKeys.searchByPrice.tr(),
                          style:
                              openSansExtraBold.copyWith(color: darkGreyColor),
                        ),
                        //  BlocBuilder(builder: (context,state){
//
//                     BlocBuilder<FilterSearchAdsCubit, FilterSearchAdsState>(
//                     //  listener: (context,state){},
//                       builder: (context, state) {
//
//                         return
//                       },
//                     ),
                        (state is GetPriceRangeLoadingState ||
                                filterSearchAdsCubit.priceRangeModel?.data ==
                                    null ||
                                filterSearchAdsCubit.values == null)
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Container(
                                    height: context.width * 0.2,
                                    child: RangeSlider(
                                      activeColor: goldColor,
                                      max: filterSearchAdsCubit
                                          .priceRangeModel!.data!.maxPrice!
                                          .toDouble(),
                                      min: filterSearchAdsCubit
                                          .priceRangeModel!.data!.minPrice!
                                          .toDouble(),
                                      values: filterSearchAdsCubit.values!,
                                      onChanged: (newVal) {
                                        filterSearchAdsCubit
                                            .changeValueRange(newVal);
                                      },
                                      divisions: 8,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${filterSearchAdsCubit.values!.start.toStringAsFixed(0)}',
                                            style: openSansMedium.copyWith(
                                                color: goldColor),
                                          ),
                                          SizedBox(
                                              width: context.width * 0.005.w),
                                          riyalWidget(context),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${filterSearchAdsCubit.values!.end.toStringAsFixed(0)}',
                                            style: openSansMedium.copyWith(
                                                color: goldColor),
                                          ),
                                          SizedBox(
                                              width: context.width * 0.005.w),
                                          riyalWidget(context),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                        // }),
                        // <FilterController>(builder: (filterController) {
                        //
                        //   }),
                        SizedBox(
                          height: context.height * 0.06,
                        ),
                        Text(
                          LocaleKeys.area.tr(),
                          style:
                              openSansExtraBold.copyWith(color: darkGreyColor),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_LARGE,
                        ),
                        //  AreaGridViewFilter(),
                        CustomTextField(
                          labelText:
                              '${LocaleKeys.area.tr()} ${LocaleKeys.squareArea.tr()}',
                          controller: areaController,
                          keyboardType: TextInputType.number,
                          maxHeight: context.width * 0.2,
                          minHeight: context.width * 0.15,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return LocaleKeys.areaRequired.tr();
                            }
                          },
                        ),
                        Text(
                          LocaleKeys.purpose.tr(),
                          style:
                              openSansExtraBold.copyWith(color: darkGreyColor),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_LARGE,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: context.width * 0.06),
                          child: PurposeGridViewFilter(),
                        ),
                        CustomButton(
                          textButton: LocaleKeys.search.tr(),
                          onPressed: () {
                            if (widget.id == 1) {
                              navigateForward(AdsOnMap(
                                categoryId: filterSearchAdsCubit.categoryId,
                                space: areaController.text,
                                adsType: addRealAdsCubit.purposeId,
                              ));
                            } else {
                              filterSearchAdsCubit.searchAdsById(
                                  context: context,
                                  page: 1,
                                  categoryId: filterSearchAdsCubit.categoryId,
                                  adsType: addRealAdsCubit.purposeId ?? '',
                                  space: areaController.text);
                              // Navigator.pop(context);
                              navigateForwardReplace(CategoryScreen(
                                //   model:filterSearchAdsCubit.searchResultModel ,
                                nameOfCategory: addRealAdsCubit.adsType ??
                                    LocaleKeys.all.tr(),
                                index: addRealAdsCubit.adsId ?? 0,
                              ));
                            }

                            //filterSearchAdsCubit.searchAdsById();
                          },
                          color: darkGreyColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      //   );
      // },
    );
  }
}
