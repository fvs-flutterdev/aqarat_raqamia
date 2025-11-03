import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ad_info_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/edit_ad_cubit/edit_ad_info_cubit/state.dart';

import '../../../../utils/dimention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/add_real_ads/cubit.dart';
import '../../../../bloc/add_real_ads/state.dart';
import '../../../../utils/text_style.dart';

class VisionListWidget extends StatelessWidget {
  // String title;
  // Function onTap;
  // int indexL
  // const HorizontalListRoomsNo({super.key});

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit =context.read<AddRealAdsCubit>();
    return BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
      builder: (context, state) {
        return Container(
          height: 70,
          child: GridView.builder(
              itemCount:
                  addRealAdsCubit.resourceCreateModel.prolongation?.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 70.w,
                mainAxisSpacing: 5.w,
                crossAxisCount: 1,
                childAspectRatio: 16 / 13,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    addRealAdsCubit.changeVisionStatus(index: index);
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
                            padding: EdgeInsets.all(8),
                            height: 50.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_LARGE),
                                color: addRealAdsCubit.resourceCreateModel
                                        .prolongation![index].istabbed
                                    ? lightGrey
                                    : whiteColor),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  addRealAdsCubit.resourceCreateModel
                                          .prolongation![index].title ??
                                      '',
                                  //visionList[index].title,
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




class VisionListForEditWidget extends StatelessWidget {
 final bool? isSameVision;
 final String? visionName;
  // String title;
  // Function onTap;
  // int indexL
   const VisionListForEditWidget({super.key, this.isSameVision,this.visionName});

  @override
  Widget build(BuildContext context) {
    var editMyAd =context.read<EditAdInfoCubit>();
    return BlocBuilder<EditAdInfoCubit, EditAdInfoState>(
      builder: (context, state) {
        return Container(
          height: 70,
          child: GridView.builder(
              itemCount:
              editMyAd.resourceCreateModel.prolongation?.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 70.w,
                mainAxisSpacing: 5.w,
                crossAxisCount: 1,
                childAspectRatio: 16 / 13,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    editMyAd.changeVisionForEditStatus(index: index);
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
                            padding: EdgeInsets.all(8),
                            height: 50.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_LARGE),
                                color: editMyAd.resourceCreateModel
                                    .prolongation![index].istabbed ||isSameVision==true&&visionName==editMyAd.resourceCreateModel.prolongation![index].title
                                    ? lightGrey
                                    : whiteColor),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  editMyAd.resourceCreateModel
                                      .prolongation![index].title ??
                                      '',
                                  //visionList[index].title,
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
