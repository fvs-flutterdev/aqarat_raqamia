import 'package:aqarat_raqamia/bloc/profile_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/subscribtion_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/subscribtion_cubit/state.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/adaptive_dialog_loader.dart';
import 'package:aqarat_raqamia/view/base/auth_header.dart';
import 'package:aqarat_raqamia/view/base/custom_text_field.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:aqarat_raqamia/view/error_widget/error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../model/static_model/suscribe_model.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/images.dart';
import '../../base/pagination_view.dart';
import '../../base/riyal_widget.dart';
import '../../base/shimmer/ads_shimmer.dart';

class PackagesScreen extends StatefulWidget {
  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  // const PackagesScreen({super.key});
  ScrollController _controller = ScrollController();
  TextEditingController promoCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      context.read<SubscribeCubit>().isDialog == false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var subscribeCubit = context.read<SubscribeCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //     title: LocaleKeys.selectYourPackage.tr(), isCanBack: false),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title:LocaleKeys.selectYourPackage.tr(), isCanBack: false),
          ),
          Expanded(
            child: BlocConsumer<SubscribeCubit, SubscribeState>(
              listener: (context, state) {
                if (state is PaySubscribeDataLoadingState &&
                    subscribeCubit.isDialog == true) {
                  adaptiveDialogLoader(context: context);
                } else if (state is PaySubscribeDataErrorState) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return state is GetSubscribeDataErrorState
                    ? CustomErrorWidget(
                        reload: () {
                          context
                              .read<SubscribeCubit>()
                              .getPackagesSubscription(page: 1);
                        },
                      )
                    : Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          SingleChildScrollView(
                            controller: _controller,
                            reverse: false,
                            child: Padding(
                              padding: EdgeInsets.all(context.width * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.subscriptions.tr(),
                                        style: openSansBold.copyWith(
                                            color: darkGreyColor),
                                      ),
                                      Image.asset(Images.Payment_Logo,
                                          height: context.height * 0.07,
                                          width: context.width * 0.4),
                                      //  SvgPicture.asset(Images.Payment_Logo,height: context.height*0.07,width: context.width*0.1),
                                    ],
                                  ),
                                  subscribeCubit.isGet == false
                                      ? AdsShimmer()
                                      : PaginatedListView(
                                          last: subscribeCubit
                                              .allPackageSubscription.meta!.lastPage!,
                                          isChat: false,
                                          offset: subscribeCubit
                                              .allPackageSubscription
                                              .meta!
                                              .currentPage!,
                                          onPaginate: (int offset) async {
                                            print(offset);
                                            await subscribeCubit
                                                .getPackagesSubscription(
                                                    page: offset);
                                          },
                                          scrollController: _controller,
                                          totalSize: subscribeCubit
                                                  .allPackageSubscription.meta?.to ??
                                              15,
                                          // reverse: false,
                                          enabledPagination: true,
                                          productView: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: context.width * 0.15),
                                            child: ListView.builder(
                                                reverse: false,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                // controller: _controller,
                                                itemCount: subscribeCubit
                                                    .allPackageSubscription
                                                    .data!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    clipBehavior:
                                                        Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                context.width *
                                                                    0.03)),
                                                    elevation: 3,
                                                    child: Container(
                                                      //   margin: EdgeInsets.all(context.width * 0.04),
                                                      height: context.width * 0.25,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  context.width *
                                                                      0.03),
                                                          border: Border.all(
                                                              color: subscribeCubit
                                                                      .allPackageSubscription
                                                                      .data![index]
                                                                      .istabbed!
                                                                  ? goldColor
                                                                  : lightYellowColor)),
                                                      child: Center(
                                                        child: ListTile(
                                                          onTap: () {
                                                            return subscribeCubit
                                                                .changeSubscribeState(
                                                                    index);
                                                          },
                                                          leading: Image.asset(
                                                              Images.LOGO_SPLASH),
                                                          title: Text(
                                                              subscribeCubit
                                                                      .allPackageSubscription
                                                                      .data![index]
                                                                      .name ??
                                                                  "",
                                                              style: openSansBold
                                                                  .copyWith(
                                                                      color:
                                                                          darkGreyColor)),
                                                          // Text(
                                                          //   '${LocaleKeys.For.tr()} ${subscribeCubit.allPackageSubscription.data![index].type}',
                                                          //   style:
                                                          //       openSansBold.copyWith(
                                                          //           color:
                                                          //               darkGreyColor),
                                                          // ),
                                                          subtitle: Row(
                                                            children: [
                                                              RichText(
                                                                  text: TextSpan(
                                                                      text:
                                                                          '${subscribeCubit.allPackageSubscription.data![index].price}',
                                                                      style: openSansBold
                                                                          .copyWith(
                                                                              color:
                                                                                  goldColor),
                                                                      children: [
                                                                    TextSpan(
                                                                        text:
                                                                            ' \n"${LocaleKeys.For.tr()} ${subscribeCubit.allPackageSubscription.data![index].type}"',
                                                                        style: openSansBold
                                                                            .copyWith(
                                                                                color:
                                                                                    goldColor))
                                                                  ])),
                                                              SizedBox(width: context.width*0.005.w,),
                                                              riyalWidget(context),
                                                            ],
                                                          ),
                                                          //   Text(
                                                          //   '${subscribeCubit.allPackageSubscription.data![index].price} ${LocaleKeys.currency.tr()}',
                                                          //   style:
                                                          //       openSansBold.copyWith(
                                                          //           color: goldColor),
                                                          // ),
                                                          trailing: Checkbox(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius
                                                                      .circular(context
                                                                              .width *
                                                                          0.04)),
                                                              value: subscribeCubit
                                                                  .allPackageSubscription
                                                                  .data![index]
                                                                  .istabbed!,
                                                              onChanged: (value) {
                                                                subscribeCubit
                                                                    .changeSubscribeState(
                                                                        index);
                                                                print('value');
                                                              }),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(context.width * 0.04),
                            child: CustomButton(
                              color: subscribeCubit.subscribeId == null
                                  ? null
                                  : darkGreyColor,
                              textButton: LocaleKeys.subscribe.tr(),
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                                        return Padding(
                                          padding:  EdgeInsetsDirectional.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom,
                                          ),
                                          child: Container(

                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(LocaleKeys.selectPaymentMethod.tr(),style: openSansExtraBold.copyWith(color: redColor),),
                                             //   SizedBox(height: context.height*0.3,),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),

                                                    itemCount: 2,
                                                    itemBuilder: (context, index) {
                                                      return CheckboxListTile.adaptive(

                                                          title: Text(subscribeModel[index]
                                                              .title),
                                                          value: subscribeModel[index].isTabbed,
                                                          onChanged: (val) {
                                                            setState((){
                                                              subscribeCubit.changePaymentValueState(index);
                                                            });

                                                          });
                                                    }),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.only(start: context.width*0.05,end:context.width*0.05),
                                                  child: CustomTextField(labelText: LocaleKeys.discountCoupon.tr(),controller: promoCodeController,),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.only(start: context.width*0.05,end:context.width*0.05,bottom: context.height*0.04),
                                                  child: CustomButton(

                                                      color:darkGreysColor,
                                                      textButton: LocaleKeys.pay.tr(), onPressed: (){
                                                    if(subscribeModel[0].isTabbed==true){
                                                      subscribeCubit.payForSubscription(
                                                          context: context,
                                                          isWallet: true,
                                                          promoCode: promoCodeController.text);
                                                    }else{
                                                      subscribeCubit.payForSubscription(
                                                          context: context,
                                                          isWallet: false,
                                                          promoCode: promoCodeController.text);
                                                    }
                                                  }),
                                                )
                                                // CheckboxListTile.adaptive(
                                                //     title: Text(subscribeModel[0].title),
                                                //     value: subscribeModel[0].isTabbed,
                                                //     onChanged: (val) {}),
                                                // CheckboxListTile.adaptive(
                                                //     title: Text(subscribeModel[1].title),
                                                //     value: subscribeModel[1].isTabbed,
                                                //     onChanged: (val) {}),
                                              ],
                                            ),
                                          ),
                                        );
                                      },);

                                    });
                                ///
                                // print('khdaskjhdkjashdka');

                                // Get.to(() => PaymentScreenWebView());
                                // subscribeCubit.payForSubscription(
                                //     context: context,
                                //     isWallet: false,
                                //     promoCode: promoCodeController.text);
                                // if(state is PaySubscribeDataSuccessState){
                                //   LaravelEcho.init(token:userId);
                                // }
                              },
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
