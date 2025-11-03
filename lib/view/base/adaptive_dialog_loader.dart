
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/subscribtion_cubit/cubit.dart';
import '../../translation/locale_keys.g.dart';

bool isDismiss=true;

//BuildContext? dialogContext;
  adaptiveDialogLoader({required BuildContext context }){
    if(context.read<SubscribeCubit>().isDialog==true) {
      return showAdaptiveDialog(
          barrierDismissible: false,

          context: context, builder: (context) {
       // dialogContext = context;
        return AlertDialog.adaptive(

          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.pleaseWait.tr(),
                    style: openSansRegular.copyWith(color: darkGreyColor),),
                  adaptiveCircleProgress(),
                ],
              ),
            ],
          ),
        );
      });
    }else{
      return Container();
    }
}


Widget adaptiveCircleProgress(){
    return Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: goldColor,
          valueColor: AlwaysStoppedAnimation<Color>(
            darkGreyColor, //<-- SEE HERE
          ),
        ));
}