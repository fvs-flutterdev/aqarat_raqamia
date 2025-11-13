import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../utils/media_query_value.dart';
import '../../../../utils/text_style.dart';
import '../../../../view/base/lunch_widget.dart';
import '../../../bloc/start_app_cubit/cubit.dart';
import '../../../bloc/start_app_cubit/state.dart';
import '../../../main.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/dimention.dart';
import '../../../utils/images.dart';
import '../account_type/account_type.dart';

class BoardingScreen extends StatefulWidget {
  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    context.read<StartAppCubit>().getBoardingData();
  }

  // BoardingScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var startAppCubit = context.read<StartAppCubit>();
    responsiveInit(context);
    return Scaffold(
        //appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
        body: Column(
      children: [
        BlocBuilder<StartAppCubit, StartAppState>(
          builder: (context, state) {
            if (state is GetBoardingDataSuccessState) {
              return bardingSuccessWidget(
                  pageController: _pageController,
                  startAppCubit: startAppCubit);
            } else if (state is GetBoardingDataLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: goldColor,
                  strokeWidth: 4,
                ),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Image.asset(Images.Error),
                    Text(LocaleKeys.networkError.tr()),
                    TextButton(
                      onPressed: () {
                        startAppCubit.getBoardingData();
                      },
                      child: Text(
                        LocaleKeys.reload.tr(),
                        style: openSansBlack.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: darkGreyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Image.asset(
                Images.BOARDING_LOGO,
                height: context.height * 0.1.h,
                width: context.width * 0.3.w,
              )),
        ),
      ],
    ));
  }
}

class bardingSuccessWidget extends StatelessWidget {
  const bardingSuccessWidget({
    super.key,
    required PageController pageController,
    required this.startAppCubit,
  }) : _pageController = pageController;

  final PageController _pageController;
  final StartAppCubit startAppCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: startAppCubit.boardingContentModel.data!.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: context.width * 1.1.h,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FittedBox(
                        fit: BoxFit.fill,
                        child: FancyShimmerImage(
                          imageUrl: startAppCubit
                                  .boardingContentModel.data![index].image ??
                              '',
                          errorWidget: Icon(Icons.error),

                          // fit: BoxFit.fill,
                          height: context.height,
                          width: context.width,
                        )
                        // Image.network(
                        //       startAppCubit.boardingContentModel.data![index]
                        //               .image ??
                        //           '',
                        //       fit: BoxFit.fill,
                        //       height: context.height,
                        //       width: context.width,
                        //     ),
                        ),
                    GestureDetector(
                      onTap: () {
                        if (index == 1) {
                          navigateForward(AccountTypeScreen());
                          print('object');
                        } else {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 750),
                              curve: Curves.ease);
                        }
                      },
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: Dimensions.PADDING_SIZE_LARGE,
                            bottom: Dimensions.PADDING_SIZE_OVER_LARGE,
                          ),
                          child: CircularPercentIndicator(
                            radius: Dimensions.RADIUS_EXTRA_LARGE,
                            lineWidth: 1.0,
                            percent: index == 0 ? 0.5 : 1.0,
                            center: index == 1
                                ? CircleAvatar(
                                    radius: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                    backgroundColor: whiteColor,
                                    child: Text(
                                      LocaleKeys.start.tr(),
                                      style: openSansRegular.copyWith(
                                        color: goldColor,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                    backgroundColor: goldColor,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: whiteColor,
                                    )),
                            progressColor: goldColor,
                            backgroundColor: whiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            navigateForward(AccountTypeScreen());
                          },
                          child: Text(
                            LocaleKeys.skip.tr(),
                            style: openSansBlack.copyWith(
                                fontSize: context.height * 0.02.sp,
                                color: darkGreyColor),
                          ),
                        ),
                        Html(
                            data: startAppCubit
                                    .boardingContentModel.data![index].title ??
                                ''),
                        Html(
                            data: startAppCubit.boardingContentModel
                                    .data![index].description ??
                                ''),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
