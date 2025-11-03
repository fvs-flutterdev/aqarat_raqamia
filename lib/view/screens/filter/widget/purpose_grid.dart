import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ad_info_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ad_info_cubit/state.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/add_real_ads/cubit.dart';
import '../../../../bloc/add_real_ads/state.dart';
import '../../../../utils/dimention.dart';

class PurposeGridViewFilter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   var addRealAdsCubit=context.read<AddRealAdsCubit>();
    return BlocConsumer<AddRealAdsCubit, AddRealAdsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Container(
      height: context.height*0.075.sp,
      child: GridView.builder(
          itemCount: addRealAdsCubit.resourceCreateModel.type?.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: context.width*0.21,
            mainAxisSpacing: context.width*0.02,
            crossAxisCount: 1,
            childAspectRatio: 16 / 13,
          ),
          itemBuilder: (context, index) {

            return GestureDetector(
              onTap: () {
                addRealAdsCubit.changePurposeStatus(index: index);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_LARGE)),
                    color: darkGreyColor,
                    child: Container(
                        padding: EdgeInsets.all(8.sp),
                        height:context.height*0.06.sp ,
                        width: context.width*0.2.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.RADIUS_LARGE),
                            color:  addRealAdsCubit.resourceCreateModel.type![index].istabbed
                                ? lightGrey
                                : whiteColor),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              addRealAdsCubit.resourceCreateModel.type![index].name??'',
                              style: openSansRegular.copyWith(
                                  color: darkGreyColor),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            );
          }),
    );
  },
);
  }
}

class PurposeGridViewForEditFilter extends StatelessWidget {
 final bool? isSamePurpose;
 final  String? purposeId;
  PurposeGridViewForEditFilter({this.isSamePurpose,this.purposeId});
  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit=context.read<EditAdInfoCubit>();
    return BlocConsumer<EditAdInfoCubit, EditAdInfoState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          height: context.height*0.075.sp,
          child: GridView.builder(
              itemCount: addRealAdsCubit.resourceCreateModel.type?.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: context.width*0.21,
                mainAxisSpacing: context.width*0.02,
                crossAxisCount: 1,
                childAspectRatio: 16 / 13,
              ),
              itemBuilder: (context, index) {

                return GestureDetector(
                  onTap: () {
                    addRealAdsCubit.changePurposeStatus(index: index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_LARGE)),
                        color: darkGreyColor,
                        child: Container(
                            padding: EdgeInsets.all(8.sp),
                            height:context.height*0.06.sp ,
                            width: context.width*0.2.sp,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_LARGE),
                                color:  addRealAdsCubit.resourceCreateModel.type![index].istabbed || (isSamePurpose==true&&
                                    purposeId==addRealAdsCubit.resourceCreateModel.type![index].id.toString())
                                    ? lightGrey
                                    : whiteColor),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  addRealAdsCubit.resourceCreateModel.type![index].name??'',
                                  style: openSansRegular.copyWith(
                                      color: darkGreyColor),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}