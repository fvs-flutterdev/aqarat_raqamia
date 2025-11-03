import 'dart:developer';

import 'package:aqarat_raqamia/bloc/notification_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/dynamic_model/notifications_model.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(InitialNotificationState());

  late NotificationsModel notificationsModel;
  bool isGetNotification = false;

  getNotificationData({required int page}) {
    isGetNotification = false;
    DioHelper.getData(
            url: BaseUrl.baseUrl + BaseUrl.GetNotificationModel,
            token: token,
            page: page)
        .then((value) {
      debugPrint(value.data.toString());
      if (page == 1) {
        notificationsModel = NotificationsModel.fromJson(value.data);
      } else {
        notificationsModel.meta?.currentPage =
            NotificationsModel.fromJson(value.data).meta?.currentPage;
        notificationsModel.meta?.lastPage =
            NotificationsModel.fromJson(value.data).meta?.lastPage;
        notificationsModel.meta?.total =
            NotificationsModel.fromJson(value.data).meta?.total;
        notificationsModel.meta?.perPage =
            NotificationsModel.fromJson(value.data).meta?.perPage;
        notificationsModel.data
            ?.addAll(NotificationsModel.fromJson(value.data).data ?? []);
      }
      emit(GetNotificationSuccessState());
      isGetNotification = true;
    }).catchError((error) {
      log(error.toString());
      isGetNotification = true;
      emit(GetNotificationErrorState(error: error.toString()));
    });
  }
}
