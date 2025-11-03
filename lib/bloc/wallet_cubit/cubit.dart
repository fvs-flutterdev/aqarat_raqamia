import 'dart:developer';

import 'package:aqarat_raqamia/bloc/wallet_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/dynamic_model/charge_wallet_pusher_response.dart';
import '../../model/dynamic_model/subscribtion_callback_model.dart';
import '../../view/screens/subscribtion_screen/web_view_pay/web_view.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(InitialWalletState());

  late SubscriptionCallBackModel subscriptionCallBackModel;

  chargeWallet({required String chargeValue}) {
    emit(ChargeWalletLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.ChargeWallet,
        token: token,
        data: {
          "amount": chargeValue,
        }).then((value) {
      print(value.data);
      subscriptionCallBackModel =
          SubscriptionCallBackModel.fromJson(value.data);
      navigateForward(PaymentWebView(
        subscriptionCallBackModel: subscriptionCallBackModel,
        url: subscriptionCallBackModel.callbackUrl!,
        redirectUrl: subscriptionCallBackModel.url!,
        onError: (error) {
          print('$error /////////////////');
        },
        onSuccess: (param) {
          print('//////////////$param');
        },
      ));
      emit(ChargeWalletSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(ChargeWalletErrorState(error: error.toString()));
    });
  }

  late ChargeWalletResponseModel chargeWalletResponseModel;
  bool loading = true;
  bool loadingError = false;
  handelWalletsResponsePayment(Map<String, dynamic> data) {
    try {
      loading = true;
      chargeWalletResponseModel = ChargeWalletResponseModel.fromJson(data);
      emit(HandleChargeWalletResponseState());
      loading = false;
      print('Model Message ${chargeWalletResponseModel.paymentDetails}');
    } catch (e) {
      loadingError = true;
      emit(HandleChargeWalletResponseErrorState(error: e.toString()));
    }
  }

}
