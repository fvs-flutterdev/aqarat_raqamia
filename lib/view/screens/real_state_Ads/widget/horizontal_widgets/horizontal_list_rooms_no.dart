import '../../../../../utils/dimention.dart';
import '../../../../../utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../bloc/add_real_ads/cubit.dart';
import '../../../../../bloc/add_real_ads/state.dart';
import '../../../../../utils/text_style.dart';

//ignore: must_be_immutable
class HorizontalListRoomsNo extends StatelessWidget {
  // String title;
  // Function onTap;
  // int indexL
  // const HorizontalListRoomsNo({super.key});
  TextEditingController roomNoController = TextEditingController();

  HorizontalListRoomsNo({required this.roomNoController});

  @override
  Widget build(BuildContext context) {
    var addRealAdsCubit = AddRealAdsCubit.get(context);
    return BlocBuilder<AddRealAdsCubit, AddRealAdsState>(
      builder: (context, state) {
        return Container(
          height: 70.sp,
          child: GridView.builder(
              itemCount:
                  addRealAdsCubit.resourceCreateModel.roomsNumber?.length,
              //roomsNoModel.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 50.w,
                  mainAxisSpacing: 5.w,
                  crossAxisCount: 1),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    addRealAdsCubit.changeRoomsCountStatus(index: index);
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
                            margin: EdgeInsets.all(addRealAdsCubit
                                        .resourceCreateModel
                                        .roomsNumber
                                        ?.last ==
                                    true
                                ? Dimensions.PADDING_SIZE_DEFAULT
                                : 0),
                            height: context.width * 0.1,
                            width: context.width * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_LARGE),
                                color: addRealAdsCubit.resourceCreateModel
                                        .roomsNumber![index].istabbed
                                    //roomsNoModel[index].isTabbed
                                    ? lightGrey
                                    : whiteColor),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  addRealAdsCubit.resourceCreateModel
                                          .roomsNumber![index].title ??
                                      '',
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
