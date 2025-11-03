import 'dart:async';
import 'dart:io';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../view/base/adaptive_dialog_loader.dart';
import '../../../../../view/base/auth_header.dart';
import '../../../../../view/base/custom_text_field.dart';
import '../../../../../view/base/full_screen_image/full_screen_image.dart';
import '../../../../../view/base/lunch_widget.dart';
import '../../../../../view/base/main_button.dart';
import '../../../../../view/base/shimmer/contact_us_shimmer.dart';
import '../../../../../view/error_widget/error_widget.dart';
import '../../../../../view/screens/location/utility.dart';
import '../../../../../view/screens/my_orders/widget/offer_price_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc/client_oder_cubit/current_order_cubit/cubit.dart';
import '../../../bloc/client_oder_cubit/current_order_cubit/state.dart';
import '../../../bloc/client_oder_cubit/finished_order_cubit/cubit.dart';
import '../../../bloc/client_oder_cubit/new_oder_cubit/cubit.dart';
import '../../../bloc/client_oder_cubit/new_oder_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../base/carousel_slider_widget.dart';
import '../../base/pagination_view.dart';
import '../../base/show_toast.dart';
import '../providers/my_orders/widget/rate_widget.dart';
import '../providers/provider_profile/provider_details_screen.dart';

//ignore: must_be_immutable
class ClientOrderDetailsScreen extends StatefulWidget {
  dynamic orderId;

  ClientOrderDetailsScreen({
    required this.orderId,
  });

  @override
  State<ClientOrderDetailsScreen> createState() =>
      _ClientOrderDetailsScreenState();
}

class _ClientOrderDetailsScreenState extends State<ClientOrderDetailsScreen> {
  final _scrollController = ScrollController();

  // var eventTime = DateTime.parse(ordersClientCubit.priceOfferModel.data?[index].bidDuration?.bidDuration??'');
  static const duration = const Duration(seconds: 1);
  Timer? timer;

  // int timeDiff = eventTime.difference(DateTime.now()).inSeconds;
  bool isActive = true;

  handleTick(eventTime, int timeDiff) {
    if (timeDiff > 0) {
      if (isActive) {
        setState(() {
          if (eventTime != DateTime.now()) {
            timeDiff = timeDiff - 1;
          } else {
            print('Times up!');
            //Do something
          }
        });
      }
    }
  }

  @override
  void initState() {
    // widget.serviceStatus == 'pending'
    //     ?
    context.read<NewOrdersClientCubit>().getOrderById(id: widget.orderId);
    context
        .read<NewOrdersClientCubit>()
        .getPricesOfferList(orderId: widget.orderId, page: 1);
    super.initState();
    // context.read<NewOrdersClientCubit>().getOrderById(id: widget.orderId);

    //  : print('');
  }

  @override
  void dispose() {
    context.read<ClientCurrentOrderCubit>().rateNotesController.dispose();
    // rateNotesController.dispose();
    _scrollController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('///////////////////////${widget.index}');
    var ordersClientCubit = context.read<NewOrdersClientCubit>();
    var currentOrdersClientCubit = context.read<ClientCurrentOrderCubit>();
    var finishedOrderCubit = context.read<ClientFinishedOrderCubit>();
    return BlocConsumer<NewOrdersClientCubit, NewOrdersClientState>(
      listener: (context, state) {
        if (state is AcceptOfferPriceClientLoadingState ||
            state is PayOfferPriceClientLoadingState ||
            state is DeclinedOfferPriceClientLoadingState||state is DeleteOrderByIdClientLoadingState) {
          adaptiveDialogLoader(context: context);
        } else if (state is AcceptOfferPriceClientErrorState ||
            state is PayOfferPriceClientErrorState ||
            state is DeclinedOfferPriceClientErrorState||state is DeleteOrderByIdClientErrorState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          // appBar: AuthHeader(
          //   title: '${LocaleKeys.orderNo.tr()} ${widget.orderId}',
          // ),
          body:
              ordersClientCubit.isGetOrderById == false ||
                      ordersClientCubit.isPricesOffer == false
                  ? Column(
                      children: [
                        Container(
                          height: context.height * 0.17.h,
                          margin: EdgeInsets.zero,
                          child: AuthHeader(
                              title:
                                  '${LocaleKeys.orderNo.tr()} ${widget.orderId}'),
                        ),
                        Expanded(
                          child: Center(
                            child: adaptiveCircleProgress(),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          height: context.height * 0.17.h,
                          margin: EdgeInsets.zero,
                          child: AuthHeader(
                              title:
                                  '${LocaleKeys.orderNo.tr()} ${widget.orderId}'),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    labelText: LocaleKeys.mainService.tr(),
                                    controller: TextEditingController(
                                        text: ordersClientCubit.orderByIdModel
                                                .data?.servicesId?.name
                                            // widget.serviceName
                                            ??
                                            ''),
                                    backgroundColor: lightGrey,
                                    isEnabled: false,
                                  ),
                                  CustomTextField(
                                    labelText: LocaleKeys.subService.tr(),
                                    controller: TextEditingController(
                                        text: ordersClientCubit.orderByIdModel
                                                .data?.subServicesId?.name
                                            //  widget.subServiceName
                                            ??
                                            ''),
                                    backgroundColor: lightGrey,
                                    isEnabled: false,
                                  ),
                                  // widget.serviceStatus == 'pending'
                                  ordersClientCubit
                                              .orderByIdModel.data?.status ==
                                          'pending'
                                      ? SizedBox()
                                      : CustomTextField(
                                          labelText:
                                              LocaleKeys.servicePrice.tr(),
                                          controller: TextEditingController(
                                              text: ordersClientCubit
                                                  .orderByIdModel
                                                  .data
                                                  ?.acceptedPriceOffers
                                                  ?.price
                                                  .toString()
                                              //  widget.price!
                                              ),
                                          backgroundColor: lightGrey,
                                          isEnabled: false,
                                        ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (ordersClientCubit.orderByIdModel.data
                                                      ?.lat ==
                                                  null ||
                                              ordersClientCubit.orderByIdModel
                                                      .data?.lan ==
                                                  null
                                          // widget.lat == null || widget.lng == null
                                          ) {
                                        showCustomSnackBar(
                                            //   context: context,
                                            message: LocaleKeys.error.tr(),
                                            state: ToastState.ERROR);
                                        //showToast(text:LocaleKeys.noLocationTransportation.tr() , state: ToastState.ERROR);
                                      } else {
                                        if (Platform.isIOS) {
                                          await launchUrl(Uri.parse(
                                              "comgooglemaps://?q=${ordersClientCubit.orderByIdModel.data?.lat},"
                                              "${ordersClientCubit.orderByIdModel.data?.lan}&key=$GOOGLE_API_KEY"));
                                        } else {
                                          await launchUrl(Uri.parse(
                                              'google.navigation:q='
                                              '${ordersClientCubit.orderByIdModel.data?.lat}, '
                                              '${ordersClientCubit.orderByIdModel.data?.lan}'
                                              '&key=$GOOGLE_API_KEY'));
                                        }
                                      }
                                    },
                                    child: CustomTextField(
                                      labelText: LocaleKeys.location.tr(),
                                      isEnabled: false,
                                      controller: TextEditingController(
                                          text: ordersClientCubit
                                              .orderByIdModel.data?.locations
                                          //widget.location
                                          ),
                                    ),
                                  ),
                                  CustomTextField(
                                    labelText:
                                        LocaleKeys.serviceDescription.tr(),
                                    isBig: true,
                                    lines: 9,
                                    maxHeight: context.width * 0.39.sp,
                                    //context.width * 0.39,
                                    minHeight: context.width * 0.39.sp,
                                    controller: TextEditingController(
                                        text: ordersClientCubit
                                            .orderByIdModel.data?.notes
                                        //widget.note
                                        ),
                                    isEnabled: false,
                                  ),
                                  ordersClientCubit
                                          .orderByIdModel.data!.photos!.isEmpty
                                      //  widget.photos!.isEmpty
                                      ? const SizedBox()
                                      : Text(
                                          LocaleKeys.attachImage.tr(),
                                          style: openSansMedium.copyWith(
                                              color: darkGreyColor),
                                        ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                  ),
                                  ordersClientCubit
                                          .orderByIdModel.data!.photos!.isEmpty
                                      //  widget.photos!.isEmpty
                                      ? const SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            // print(ordersClientCubit
                                            //     .orderByIdModel
                                            //     .data!
                                            //     .photos
                                            //     ?.iterator);
                                            navigateForward(FullImageListScreen(
                                              // index: ordersClientCubit.orderByIdModel.data!.photos.,
                                              itemCount: ordersClientCubit
                                                  .orderByIdModel
                                                  .data!
                                                  .photos!
                                                  .length,
                                              image: ordersClientCubit
                                                      .orderByIdModel
                                                      .data!
                                                      .photos ??
                                                  [],

                                              // itemCount: widget.photos!.length,
                                              // image: widget.photos??[]
                                            ));
                                          },
                                          child: CustomCarouselSliderWidget(
                                            photos: ordersClientCubit
                                                    .orderByIdModel
                                                    .data!
                                                    .photos ??
                                                [],
                                            height: context.height * 0.25.sp,
                                            count: ordersClientCubit
                                                .orderByIdModel
                                                .data!
                                                .photos!
                                                .length,
                                            selectedIndex:
                                                ordersClientCubit.selectedIndex,
                                            changeIndexFunction: (i) {
                                              ordersClientCubit
                                                  .changeIndexCarousel(i);
                                            },
                                          ),
                                        ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                  ),
                                  ordersClientCubit
                                              .orderByIdModel.data!.status ==
                                          'pending'
                                      //  widget.serviceStatus == 'pending'
                                      ? ordersClientCubit.priceOfferModel.data
                                                  ?.isEmpty ==
                                              true
                                          ? const SizedBox()
                                          : Text(
                                              LocaleKeys.offerPrices.tr(),
                                              style: openSansBold.copyWith(
                                                  color: darkGreyColor),
                                            )
                                      : Text(
                                          LocaleKeys.serviceProvider.tr(),
                                          style: openSansBold.copyWith(
                                              color: darkGreyColor),
                                        ),
                                  ordersClientCubit.orderByIdModel.data!.status ==
                                          'pending'
                                      // widget.serviceStatus == 'pending'
                                      ? state is GetPricesOfferClientErrorState
                                          ? CustomErrorWidget(
                                              reload: () {
                                                ordersClientCubit
                                                    .getPricesOfferList(
                                                        orderId: widget.orderId,
                                                        page: 1);
                                              },
                                            )
                                          : ordersClientCubit.isPricesOffer ==
                                                  false
                                              ? ContactUsShimmer()
                                              : ordersClientCubit
                                                      .priceOfferModel
                                                      .data!
                                                      .isEmpty
                                                  ? const SizedBox()
                                                  : PaginatedListView(
                                                      last: ordersClientCubit
                                                              .priceOfferModel
                                                              .meta!
                                                              .lastPage ??
                                                          1,
                                                      offset: ordersClientCubit
                                                              .priceOfferModel
                                                              .meta!
                                                              .currentPage ??
                                                          1,
                                                      onPaginate:
                                                          (int offset) async {
                                                        print(offset);
                                                        await ordersClientCubit
                                                            .getPricesOfferList(
                                                          page: offset,
                                                          orderId:
                                                              widget.orderId,
                                                        );
                                                      },
                                                      scrollController:
                                                          _scrollController,
                                                      totalSize: ordersClientCubit.priceOfferModel.meta?.to ??
                                                          15,
                                                      // reverse: true,
                                                      enabledPagination: true,
                                                      productView:
                                                          ListView.builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  ordersClientCubit
                                                                      .priceOfferModel
                                                                      .data
                                                                      ?.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                if (timer ==
                                                                    null) {
                                                                  timer = Timer
                                                                      .periodic(
                                                                          duration,
                                                                          (Timer
                                                                              t) {
                                                                    handleTick(
                                                                        DateTime.parse(ordersClientCubit.priceOfferModel.data?[index].bidDuration?.bidDuration ??
                                                                            ''),
                                                                        DateTime.parse(ordersClientCubit.priceOfferModel.data?[index].bidDuration?.bidDuration ??
                                                                                '')
                                                                            .difference(DateTime.now())
                                                                            .inSeconds);
                                                                  });
                                                                }

                                                                int days = DateTime.parse(
                                                                            ordersClientCubit.priceOfferModel.data?[index].bidDuration?.bidDuration ??
                                                                                '')
                                                                        .difference(DateTime
                                                                            .now())
                                                                        .inSeconds ~/
                                                                    (24 *
                                                                        60 *
                                                                        60) %
                                                                    24;
                                                                int hours = DateTime.parse(
                                                                            ordersClientCubit.priceOfferModel.data?[index].bidDuration?.bidDuration ??
                                                                                '')
                                                                        .difference(
                                                                            DateTime.now())
                                                                        .inSeconds ~/
                                                                    (60 * 60) %
                                                                    24;
                                                                int minutes =
                                                                    (DateTime.parse(ordersClientCubit.priceOfferModel.data?[index].bidDuration?.bidDuration ?? '').difference(DateTime.now()).inSeconds ~/
                                                                            60) %
                                                                        60;
                                                                int seconds = DateTime.parse(
                                                                            ordersClientCubit.priceOfferModel.data?[index].bidDuration?.bidDuration ??
                                                                                '')
                                                                        .difference(
                                                                            DateTime.now())
                                                                        .inSeconds %
                                                                    60;

                                                                // print('SECOND : $seconds');
                                                                //  print('minutes : $minutes');
                                                                //  print('hours : $hours');
                                                                //  print('days : $days');

                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    navigateForward(
                                                                        ProviderDetailsScreen(
                                                                      id: ordersClientCubit
                                                                          .priceOfferModel
                                                                          .data?[
                                                                              index]
                                                                          .provider
                                                                          ?.id
                                                                          .toString(),
                                                                      achievements: ordersClientCubit
                                                                              .priceOfferModel
                                                                              .data?[index]
                                                                              .provider
                                                                              ?.achievements ??
                                                                          [],
                                                                      images_album: ordersClientCubit
                                                                              .priceOfferModel
                                                                              .data?[index]
                                                                              .provider
                                                                              ?.imagesAlbum ??
                                                                          [],
                                                                      projects: ordersClientCubit
                                                                              .priceOfferModel
                                                                              .data?[index]
                                                                              .provider
                                                                              ?.projects ??
                                                                          [],
                                                                      name: ordersClientCubit
                                                                              .priceOfferModel
                                                                              .data?[index]
                                                                              .provider
                                                                              ?.name ??
                                                                          '',
                                                                      rate: ordersClientCubit
                                                                              .priceOfferModel
                                                                              .data?[index]
                                                                              .provider
                                                                              ?.rate
                                                                              ?.toStringAsFixed(1) ??
                                                                          '',
                                                                      value: TextEditingController(
                                                                          text: ordersClientCubit.priceOfferModel.data?[index].provider?.value ??
                                                                              ''),
                                                                      imageAvatar: ordersClientCubit
                                                                              .priceOfferModel
                                                                              .data?[index]
                                                                              .provider
                                                                              ?.photo ??
                                                                          '',
                                                                      noRate: ordersClientCubit
                                                                          .priceOfferModel
                                                                          .data?[
                                                                              index]
                                                                          .provider
                                                                          ?.rate,
                                                                      notes: TextEditingController(
                                                                          text: ordersClientCubit.priceOfferModel.data?[index].provider?.notes ??
                                                                              ''),
                                                                      objectives:
                                                                          TextEditingController(
                                                                              text: ordersClientCubit.priceOfferModel.data?[index].provider?.objectives ?? ''),
                                                                      visionary:
                                                                          TextEditingController(
                                                                              text: ordersClientCubit.priceOfferModel.data?[index].provider?.visionary ?? ''),
                                                                    ));
                                                                  },
                                                                  child:
                                                                      OfferPriceWidget(
                                                                    status: ordersClientCubit
                                                                        .orderByIdModel
                                                                        .data!
                                                                        .status,
                                                                    //  widget.serviceStatus,
                                                                    id: ordersClientCubit
                                                                        .priceOfferModel
                                                                        .data?[
                                                                            index]
                                                                        .provider
                                                                        ?.id,
                                                                    image: ordersClientCubit
                                                                            .priceOfferModel
                                                                            .data?[index]
                                                                            .provider
                                                                            ?.photo ??
                                                                        '',
                                                                    name: ordersClientCubit
                                                                            .priceOfferModel
                                                                            .data?[index]
                                                                            .provider
                                                                            ?.name ??
                                                                        '',
                                                                    rate: ordersClientCubit
                                                                            .priceOfferModel
                                                                            .data?[index]
                                                                            .providerRate
                                                                            .toString() ??
                                                                        '',
                                                                    priceOffer: ordersClientCubit
                                                                            .priceOfferModel
                                                                            .data?[index]
                                                                            .price
                                                                            .toString() ??
                                                                        '',
                                                                    serviceDetails: ordersClientCubit
                                                                            .priceOfferModel
                                                                            .data?[
                                                                                index]
                                                                            .serviceDetails ??
                                                                        LocaleKeys
                                                                            .noNotes
                                                                            .tr(),
                                                                    remainingTime: ordersClientCubit
                                                                        .priceOfferModel
                                                                        .data?[
                                                                            index]
                                                                        .bidDuration
                                                                        ?.remainingTime,
                                                                    dateLine:
                                                                        '$days ${LocaleKeys.day.tr()} : $hours ${LocaleKeys.hour.tr()} : $minutes ${LocaleKeys.minute.tr()}: $seconds ${LocaleKeys.second.tr()}',
                                                                    //ordersClientCubit.priceOfferModel.data?[index].bidDuration?.remainingTime,
                                                                    accept: () {
                                                                      ordersClientCubit
                                                                          .acceptOfferPrice(
                                                                        // orderId:widget.orderId,
                                                                        orderId:
                                                                            ordersClientCubit.priceOfferModel.data![index].priceOfferId ??
                                                                                0,
                                                                        //widget.orderId,
                                                                        //   context: context
                                                                      );
                                                                    },
                                                                    refuse: () {
                                                                      ordersClientCubit
                                                                          .declineOfferPrice(
                                                                        // context:
                                                                        //     context,
                                                                        orderId:
                                                                            ordersClientCubit.priceOfferModel.data![index].priceOfferId ??
                                                                                0,
                                                                        // widget.orderId
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              }))
                                      : GestureDetector(
                                          onTap: () {
                                            navigateForward(
                                                ProviderDetailsScreen(
                                              id: ordersClientCubit
                                                  .priceOfferModel
                                                  .data?[0]
                                                  .provider
                                                  ?.id
                                                  .toString(),
                                              achievements: ordersClientCubit
                                                      .priceOfferModel
                                                      .data?[0]
                                                      .provider
                                                      ?.achievements ??
                                                  [],
                                              images_album: ordersClientCubit
                                                      .priceOfferModel
                                                      .data?[0]
                                                      .provider
                                                      ?.imagesAlbum ??
                                                  [],
                                              projects: ordersClientCubit
                                                      .priceOfferModel
                                                      .data?[0]
                                                      .provider
                                                      ?.projects ??
                                                  [],
                                              name: ordersClientCubit
                                                      .priceOfferModel
                                                      .data?[0]
                                                      .provider
                                                      ?.name ??
                                                  '',
                                              rate: ordersClientCubit
                                                      .priceOfferModel
                                                      .data?[0]
                                                      .provider
                                                      ?.rate
                                                      ?.toStringAsFixed(1) ??
                                                  '',
                                              value: TextEditingController(
                                                  text: ordersClientCubit
                                                          .priceOfferModel
                                                          .data?[0]
                                                          .provider
                                                          ?.value ??
                                                      ''),
                                              imageAvatar: ordersClientCubit
                                                      .priceOfferModel
                                                      .data?[0]
                                                      .provider
                                                      ?.photo ??
                                                  '',
                                              noRate: ordersClientCubit
                                                  .priceOfferModel
                                                  .data?[0]
                                                  .provider
                                                  ?.rate,
                                              notes: TextEditingController(
                                                  text: ordersClientCubit
                                                          .priceOfferModel
                                                          .data?[0]
                                                          .provider
                                                          ?.notes ??
                                                      ''),
                                              objectives: TextEditingController(
                                                  text: ordersClientCubit
                                                          .priceOfferModel
                                                          .data?[0]
                                                          .provider
                                                          ?.objectives ??
                                                      ''),
                                              visionary: TextEditingController(
                                                  text: ordersClientCubit
                                                          .priceOfferModel
                                                          .data?[0]
                                                          .provider
                                                          ?.visionary ??
                                                      ''),
                                            ));
                                          },
                                          //ordersClientCubit
                                          child: OfferPriceWidget(
                                            status: ordersClientCubit
                                                .orderByIdModel.data!.status,
                                            //widget.serviceStatus,
                                            image: ordersClientCubit
                                                    .priceOfferModel
                                                    .data![0]
                                                    .provider
                                                    ?.photo ??
                                                '',
                                            name: ordersClientCubit
                                                    .priceOfferModel
                                                    .data![0]
                                                    .provider
                                                    ?.name ??
                                                '',
                                            rate: ordersClientCubit
                                                    .priceOfferModel
                                                    .data![0]
                                                    .provider
                                                    ?.rate
                                                    ?.toStringAsFixed(1) ??
                                                '',
                                            priceOffer: ordersClientCubit
                                                    .priceOfferModel
                                                    .data![0]
                                                    .price
                                                    .toString() ??
                                                '',
                                            id: ordersClientCubit
                                                .priceOfferModel
                                                .data![0]
                                                .provider
                                                ?.id!,
                                          ),

                                          ///
                                        ),
                                  SizedBox(
                                    height: context.height * 0.02.sp,
                                  ),
                                  ordersClientCubit.orderByIdModel.data!
                                                  .status ==
                                              'finished' ||
                                          ordersClientCubit.orderByIdModel.data!
                                                  .status ==
                                              'declined'
                                      ? BlocConsumer<ClientCurrentOrderCubit,
                                          ClientCurrentOrderState>(
                                          listener: (context, state) {
                                            if (state
                                                is AddRateProviderLoadingState) {
                                              adaptiveDialogLoader(
                                                  context: context);
                                            } else if (state
                                                    is AddRateProviderSuccessState ||
                                                state
                                                    is AddRateProviderErrorState) {
                                              Navigator.pop(context);
                                            }
                                          },
                                          builder: (context, state) {
                                            return CustomButton(
                                                textButton: LocaleKeys
                                                    .rateServiceProvider
                                                    .tr(),
                                                color: darkGreyColor,
                                                onPressed: () {
                                                  showBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus!
                                                                .unfocus();
                                                          },
                                                          child: Container(
                                                            height:
                                                                context.height *
                                                                    0.5.sp,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.sp),
                                                            color: whiteColor,
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    LocaleKeys
                                                                        .rateServiceProvider
                                                                        .tr(),
                                                                    style: openSansBold
                                                                        .copyWith(
                                                                            color:
                                                                                darkGreyColor),
                                                                  ),
                                                                  Divider(
                                                                    endIndent:
                                                                        15.sp,
                                                                    indent:
                                                                        15.sp,
                                                                    thickness:
                                                                        2.sp,
                                                                  ),
                                                                  Image.asset(
                                                                      Images
                                                                          .RATE),
                                                                  StarRating(
                                                                    color:
                                                                        goldColor,
                                                                    size: 30.sp,
                                                                  ),
                                                                  //Spacer(),
                                                                  SizedBox(
                                                                    height: context
                                                                            .width *
                                                                        0.07.sp,
                                                                  ),
                                                                  CustomTextField(
                                                                    labelText:
                                                                        LocaleKeys
                                                                            .notes
                                                                            .tr(),
                                                                    controller:
                                                                        currentOrdersClientCubit
                                                                            .rateNotesController,
                                                                    isBig: true,
                                                                    lines: 5,
                                                                  ),
                                                                  SizedBox(
                                                                    height: context
                                                                            .width *
                                                                        0.1.sp,
                                                                  ),
                                                                  Align(
                                                                      alignment:
                                                                          AlignmentDirectional
                                                                              .bottomCenter,
                                                                      child:
                                                                          CustomButton(
                                                                        textButton: LocaleKeys
                                                                            .rateServiceProvider
                                                                            .tr(),
                                                                        onPressed:
                                                                            () {
                                                                          currentOrdersClientCubit
                                                                              .addProviderRate(
                                                                            context:
                                                                                context,
                                                                            providerId:
                                                                                ordersClientCubit.priceOfferModel.data![0].provider?.id ?? 0,
                                                                            // providerId: currentOrdersClientCubit.
                                                                            // currentOrderClientModel.data![0]
                                                                            //         .acceptedPriceOffers
                                                                            //         ?.provider
                                                                            //         ?.id ??
                                                                            //     0,
                                                                            //  notes: rateNotesController.text
                                                                          );
                                                                        },
                                                                        color:
                                                                            darkGreyColor,
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                });
                                          },
                                        )
                                      : const SizedBox(),
                                  ordersClientCubit
                                              .orderByIdModel.data!.status ==
                                          "pending"
                                      ? CustomButton(
                                          textButton:
                                              LocaleKeys.deleteOrder.tr(),
                                          onPressed: () {
                                            showAdaptiveDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        '${LocaleKeys.sureDeleteOrder.tr()} ${ordersClientCubit.orderByIdModel.data?.id.toString()}'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            ordersClientCubit.deleteOrder(
                                                                ordersClientCubit
                                                                        .orderByIdModel
                                                                        .data
                                                                        ?.id ??
                                                                    0);
                                                          },
                                                          child: Text(
                                                            LocaleKeys.yesDelete
                                                                .tr(),
                                                            style: openSansBold
                                                                .copyWith(
                                                                    color:
                                                                        redColor),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            LocaleKeys.noThanks
                                                                .tr(),
                                                            style: openSansBold
                                                                .copyWith(
                                                                    color:
                                                                        darkGreyColor),
                                                          )),
                                                    ],
                                                  );
                                                });
                                          },
                                          color: redColor,
                                        )
                                      : SizedBox(),

                                  ///
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}
