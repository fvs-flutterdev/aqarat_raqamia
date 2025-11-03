import '../../../bloc/services_cubit/cubit.dart';
import '../../../bloc/services_cubit/state.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/error_widget/error_widget.dart';
import '../../../view/screens/services/sub_services_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/dimention.dart';
import '../../../utils/images.dart';
import '../../base/auth_header.dart';
import '../../base/bottom_sheet.dart';
import '../../base/guest_widget.dart';
import '../../base/pagination_view.dart';
import '../../base/shimmer/services_shimmer.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<ServicesCubit>().getServicesData(page: 1);
    //  isBottomSheetOpen();
    super.initState();
  }

  isBottomSheetOpen() {
    print('///////////////$bottomSheetController//////////////');
    if (bottomSheetController != null) {
      bottomSheetController?.close;
      bottomSheetController = null;
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    bottomSheetController?.close;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var servicesCubit = context.read<ServicesCubit>();
    return GestureDetector(
      onTap: () {
        if (bottomSheetController != null) {
          bottomSheetController?.close;
          bottomSheetController = null;
        //  Navigator.pop(context);
        }
       // isBottomSheetOpen();
        //  bottomSheetController?.close;
        //   bottomSheetController==null?print(''):Navigator.pop(context);
      },
      child: Column(
        children: [
          Container(
              height: context.height * 0.17.sp,
              margin: EdgeInsets.zero,
              //  padding: EdgeInsetsDirectional.only(top: 100.sp),
              child: AuthHeader(
                isCanBack: false,
                title: LocaleKeys.services.tr(),
              )),
          Expanded(
            child: BlocBuilder<ServicesCubit, ServicesState>(
              builder: (context, state) {
                if (token == null) {
                  return LoginFirst();
                }
                if (servicesCubit.isGetServices == false) {
                  return ServicesShimmer();
                }
                return state is GetServicesErrorState
                    ? CustomErrorWidget(reload: () {
                        servicesCubit.getServicesData(page: 1);
                      })
                    : Padding(
                        padding: const EdgeInsets.only(
                            right: Dimensions.PADDING_SIZE_DEFAULT,
                            left: Dimensions.PADDING_SIZE_DEFAULT,
                            bottom: Dimensions.PADDING_SIZE_OVER_LARGE * 1.9),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: PaginatedListView(
                            last: servicesCubit.serviceModel.meta!.lastPage!,
                            offset:
                                servicesCubit.serviceModel.meta!.currentPage!,
                            onPaginate: (int offset) async {
                              debugPrint(offset.toString());
                              await servicesCubit.getServicesData(
                                page: offset,
                              );
                            },
                            scrollController: _scrollController,
                            totalSize:
                                servicesCubit.serviceModel.meta?.to ?? 15,
                            //  reverse: true,
                            enabledPagination: true,
                            productView: AnimationLimiter(
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  mainAxisExtent: context.height * 0.25.sp,
                                  mainAxisSpacing:
                                      Dimensions.PADDING_SIZE_DEFAULT.sp,
                                  crossAxisSpacing:
                                      Dimensions.PADDING_SIZE_DEFAULT.sp,
                                ),
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 750),
                                    columnCount: 3,
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: () {
                                            navigateForward(SubServicesScreen(
                                              serviceId: servicesCubit
                                                  .serviceModel.data![index].id
                                                  .toString(),
                                              serviceIndex: index,
                                              title: servicesCubit.serviceModel
                                                      .data![index].name ??
                                                  '',
                                            ));
                                          },
                                          child: Card(
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: goldColor),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .RADIUS_SMALL)),
                                            child: Container(
                                              height: context.height * 0.1.sp,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .RADIUS_SMALL),
                                              ),
                                              child: Column(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: servicesCubit
                                                        .serviceModel
                                                        .data![index]
                                                        .photo!,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: context.height *
                                                          0.15.sp,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      Dimensions
                                                                          .RADIUS_SMALL),
                                                              topRight: Radius
                                                                  .circular(
                                                                      Dimensions
                                                                          .RADIUS_SMALL)),
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit:
                                                                  BoxFit.cover),
                                                          color: goldColor),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      Images.SMALL_LOGO_ICON,
                                                      height: 35.sp,
                                                      width: 35.sp,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      Images.SMALL_LOGO_ICON,
                                                      height: 35.sp,
                                                      width: 35.sp,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: context.height *
                                                        0.01.sp,
                                                  ),
                                                  Text(
                                                    servicesCubit.serviceModel
                                                        .data![index].name!,
                                                    style:
                                                        openSansBold.copyWith(
                                                      color: darkGreyColor,
                                                      fontSize: context.width *
                                                          0.027.sp,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      openBottomSheet(
                                                          id: index,
                                                          fct: () {
                                                            navigateForward(
                                                                SubServicesScreen(
                                                              serviceId:
                                                                  servicesCubit
                                                                      .serviceModel
                                                                      .data![
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                              serviceIndex:
                                                                  index,
                                                              title: servicesCubit
                                                                      .serviceModel
                                                                      .data![
                                                                          index]
                                                                      .name ??
                                                                  '',
                                                            ));
                                                          },
                                                          context: context,
                                                          title: servicesCubit
                                                              .serviceModel
                                                              .data![index]
                                                              .name!,
                                                          subTitle:
                                                              servicesCubit
                                                                  .serviceModel
                                                                  .data![index]
                                                                  .notes!);
                                                    },
                                                    //1611828789
                                                    child: Text(
                                                      LocaleKeys.serviceDetails
                                                          .tr(),
                                                      style:
                                                          openSansBold.copyWith(
                                                              color: goldColor),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    servicesCubit.serviceModel.data?.length,
                              ),
                            ),
                          ),
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
