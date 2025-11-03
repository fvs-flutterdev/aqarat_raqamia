import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/add_real_ads/cubit.dart';
import '../../bloc/add_real_ads/state.dart';
import '../../bloc/region_cubit/cubit.dart';
import '../../bloc/region_cubit/state.dart';
import '../../translation/locale_keys.g.dart';
import 'custom_bottom_sheet.dart';
import 'custom_drop_down.dart';

class FilterWidgetDropDown extends StatefulWidget {
  final ScrollController scrollControllerFilter;
  const FilterWidgetDropDown({super.key,required this.scrollControllerFilter});

  @override
  State<FilterWidgetDropDown> createState() => _FilterWidgetDropDownState();
}

class _FilterWidgetDropDownState extends State<FilterWidgetDropDown> {
  @override
  Widget build(BuildContext context) {
    var regionCubit = context.read<RegionsCubit>();
    var addRealAdsCubit = context.read<AddRealAdsCubit>();
    return Row(
      children: [
        BlocBuilder<RegionsCubit, RegionState>(
          builder: (context, state) {
            return regionCubit.isGetRegion == false ||
                regionCubit.isGetRegion == null
                ? SizedBox()
                : Expanded(
              child: CustomDropDown(
                  topPadding: 0.0,
                  items: regionCubit
                      .allRegionsModel.data!
                      .map((e) {
                    return DropdownMenuItem(
                      child: Text(e.name ?? ''),
                      value: e.regionId,
                    );
                  }).toList(),
                  value: regionCubit.regionIdFilter,
                  fct: (onChange) {
                    regionCubit
                        .onChangeRegionIdFilter(
                        onChange);
                    regionCubit.regionIdFilter == 0
                        ? null
                        : regionCubit
                        .getCitiesByRegionId(
                        context: context,
                        page: 1,
                        regionId: regionCubit
                            .regionIdFilter ??
                            0)
                        .then((value) {
                      // if(regionCubit.regionId == 0){
                      //   context.read<OrdersProviderCubit>().getPendingOrdersProvider(page: 1,context: context);
                      // }else {
                      CustomBottomSheet(
                          context: context,
                          regionFilter: regionCubit
                              .regionIdFilter ??
                              0,
                          controller:
                          widget.scrollControllerFilter,
                          confirm: () {
                            Navigator.pop(
                                context);
                            // orderProviderCubit
                            //     .getPendingOrdersProvider(
                            //     page: 1,
                            //     context: context);
                          });
                      //}
                    });
                    print(onChange);
                  },
                  hint: LocaleKeys.region.tr()),
            );
          },
        ),
        SizedBox(
          width: context.width * 0.02.w,
        ),
        BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
          builder: (context, state) {
            return addRealAdsCubit.isGetResourceFeature ==
                false ||
                addRealAdsCubit.isGetResourceFeature ==
                    null
                ? SizedBox()
                : Expanded(
              child: CustomDropDown(
                  topPadding: 0.0,
                  items: addRealAdsCubit
                      .resourceCreateModel.adType!
                      .map((e) {
                    return DropdownMenuItem(
                      child: Text(e.name ?? ''),
                      value: e.id,
                    );
                  }).toList(),
                  value: addRealAdsCubit
                      .CategoryIdFilter,
                  fct: (onChange) {
                    addRealAdsCubit
                        .onChangeCategoryIdFilter(
                        onChange);

                    print(onChange);
                  },
                  hint: 'نوع العقار'),
            );
          },
        ),
      ],
    );
  }
}
