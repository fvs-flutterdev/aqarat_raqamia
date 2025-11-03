import 'dart:developer';
import 'package:aqarat_raqamia/bloc/setting_cubit/complaint_cubit/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/list_complaint_model.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_constant.dart';
import '../../../view/base/show_toast.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  ComplaintCubit() : super(InitialComplaintState());

  late MyComplaintsModel myComplaintsModel;

  getMyComplaints() {
    emit(GetMyComplaintsLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.MyComplaints, token: token)
        .then((val) {
      log(val.data.toString());
      myComplaintsModel = MyComplaintsModel.fromJson(val.data);
      emit(GetMyComplaintsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetMyComplaintsErrorState(error: error.toString()));
    });
  }

  postYourComplaint({required String subject,
    required String description,
    required String email,
    required BuildContext context}) {
    emit(PostComplaintLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.PostComplaint,
        token: token,
        data: {
          'subject': subject,
          'description': description,
          "email": email,
        }).then((value) {
      print(value.data);
      // emailController.clear();
      // subjectController.clear();
      // descriptionController.clear();
      FocusScope.of(context).unfocus();
      showCustomSnackBar(
          message: value.data['message'], state: ToastState.SUCCESS);
      emit(PostComplaintSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PostComplaintErrorState(error: error.toString()));
    });
  }
  bool isSentMessage = false;
  replayComplaint(
      {required int complaintId, required int index, required String response}) {
    emit(ReplayMyComplaintLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + '/api/complaints/$complaintId/respond',
        token: token, data: {
      "response": response
    })
        .then((val) {
      log(val.data.toString());
      myComplaintsModel.complaints![index].responses?.add(Responses(
          complaintId: complaintId,
          createdAt: DateTime.now().toString(),
          response: response,
          updatedAt: DateTime.now().toString(),
          userId: userId));
      isSentMessage = true;
      emit(ReplayMyComplaintSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(ReplayMyComplaintErrorState(error: error.toString()));
    });
  }



  // addMessageToList({String? message}) {
  //   // isPickImage = false;
  //   getAllMessageModel.data?.insert(
  //       0,
  //       ChatData(
  //         body:isPickImage?imageUrl: message,
  //         type: accountType,
  //         messageType: isPickImage?'media':'text',
  //         createDates: CreateDatesMessage(
  //             createdAt: DateTime.now().toString(),
  //             createdAtHuman: DateTime.now().toString()),
  //       ));
  //
  //   emit(SendTextMessageState());
  // }
}
