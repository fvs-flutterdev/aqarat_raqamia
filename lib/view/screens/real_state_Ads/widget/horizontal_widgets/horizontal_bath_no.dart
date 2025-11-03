import '../../../../../utils/dimention.dart';
import '../../../../../utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../bloc/add_real_ads/cubit.dart';
import '../../../../../bloc/add_real_ads/state.dart';
import '../../../../../utils/text_style.dart';

class HorizontalBathNo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit = AddRealAdsCubit.get(context);
    return BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
      builder: (context, state) {
        return Container(
          height: 70.sp,
          child: GridView.builder(
              itemCount: addRealAdsCubit.resourceCreateModel.toiletNumber?.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 50.sp,
                  mainAxisSpacing: 5.sp,
                  crossAxisCount: 1),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    addRealAdsCubit.changeBathCountStatus(index: index);
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
                            height:context.width*0.1.sp ,
                            width: context.width*0.2.sp,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_LARGE),
                                color:addRealAdsCubit.resourceCreateModel.toiletNumber![index].istabbed
                                    ? lightGrey
                                    : whiteColor),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  addRealAdsCubit.resourceCreateModel.toiletNumber![index].title??'',
                                //  bathNoModel[index].title,
                                  style: openSansMedium.copyWith(
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
