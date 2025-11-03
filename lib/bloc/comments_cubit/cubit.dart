import 'dart:developer';
import 'package:aqarat_raqamia/bloc/comments_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:aqarat_raqamia/view/base/show_toast.dart';
import 'package:bloc/bloc.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(InitialCommentsState());

  Future postCommentForAd(
      {required String adId, required String commentContent}) async {
    emit(PostCommentsLoadingState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.PostCommentForAd,
        token: token,
        data: {
          "ad_id": adId,
          "content": commentContent,
        }).then((value) {
      showCustomSnackBar(message: 'تم إرسال تعليقك بنجاح', state: ToastState.SUCCESS);
      emit(PostCommentsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(PostCommentsErrorState(error: error.toString()));
    });
  }

  rateCommentForAd({required int commentId}) {
    emit(PostRateCommentsLoadingState());
    DioHelper.postData(
            url: BaseUrl.baseUrl + "/api/ads/comments/$commentId/ratings",
            data: {
              "rating": ratingCount,
            },
            token: token)
        .then((value) {
          showCustomSnackBar(message: 'تم إرسال تقيمك بنجاح', state: ToastState.SUCCESS);
      emit(PostRateCommentsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(PostRateCommentsErrorState(error: error.toString()));
    });
  }

// getCommentForAd() {
//   emit(GetCommentsLoadingState());
//   DioHelper.getData(url: BaseUrl.baseUrl, token: token).then((value) {
//     emit(GetCommentsSuccessState());
//   }).catchError((error) {
//     log(error.toString());
//     emit(GetCommentsErrorState(error: error.toString()));
//   });
// }
}
