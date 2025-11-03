
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/text_style.dart';
import '../../base/riyal_widget.dart';

class PaymentDetailsWidget extends StatelessWidget {
  final String transaction, price, type, orderNumber, bidDuration;
  final bool isOffer;
final String? priceName;

  PaymentDetailsWidget(
      {super.key,
      required this.transaction,
      required this.price,
      required this.bidDuration,
      required this.type,
        this.priceName,
      this.isOffer = false,
      required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RichText(
        text: TextSpan(
            text: LocaleKeys.transactionId.tr(),
            style: openSansMedium.copyWith(color: darkGreyColor),
            children: [
              TextSpan(
                  style: openSansMedium.copyWith(color: goldColor),
                  text: transaction
                  // subscribeCubit.paymentResponseModel.paymentDetails?.data
                  //         ?.transaction ??
                  //     ''
                  )
            ]),
      ),
      Row(
        children: [
          RichText(
            text: TextSpan(
                text: priceName??LocaleKeys.paidPrice.tr(),
                style: openSansMedium.copyWith(color: darkGreyColor),
                children: [
                  TextSpan(
                      style: openSansMedium.copyWith(color: goldColor),
                      text: price)
                ]),
          ),
          SizedBox(width: context.width*0.005.w,),
          riyalWidget(context),
        ],
      ),
      RichText(
        text: TextSpan(
            text: LocaleKeys.serviceType.tr(),
            style: openSansMedium.copyWith(color: darkGreyColor),
            children: [
              TextSpan(
                  style: openSansMedium.copyWith(color: goldColor), text: type
                  //subscribeCubit.paymentResponseModel.paymentDetails?.data?.type ?? ''
                  )
            ]),
      ),
      RichText(
        text: TextSpan(
            text:LocaleKeys.resetNumber.tr(),
            style: openSansMedium.copyWith(color: darkGreyColor),
            children: [
              TextSpan(
                  text: orderNumber,
                  // subscribeCubit.paymentResponseModel.paymentDetails?.data
                  //         ?.orderNumber ??
                  //     '',
                  style: openSansMedium.copyWith(color: goldColor))
            ]),
      ),
      isOffer == true
          ? RichText(
              text: TextSpan(
                  text: LocaleKeys.transactionDate.tr(),
                  style: openSansMedium.copyWith(color: darkGreyColor),
                  children: [
                    TextSpan(
                        text: bidDuration,
                        // subscribeCubit.paymentResponseModel.paymentDetails?.data
                        //         ?.bidDuration ??
                        //     '',
                        style: openSansMedium.copyWith(color: goldColor))
                  ]),
            )
          : RichText(
              text: TextSpan(
                  text: LocaleKeys.serviceEndIn.tr(),
                  style: openSansMedium.copyWith(color: darkGreyColor),
                  children: [
                    TextSpan(
                        text: bidDuration,
                        // subscribeCubit.paymentResponseModel.paymentDetails?.data
                        //         ?.bidDuration ??
                        //     '',
                        style: openSansMedium.copyWith(color: goldColor))
                  ]),
            ),
    ]);
  }
}
