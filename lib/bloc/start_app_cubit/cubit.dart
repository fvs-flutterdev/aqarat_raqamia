import 'package:aqarat_raqamia/bloc/start_app_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/dynamic_model/account_type_model.dart';
import '../../model/dynamic_model/boarding_model.dart';

class StartAppCubit extends Cubit<StartAppState> {
  StartAppCubit() : super(InitialStartAppState());

  late BoardingContentModel boardingContentModel;
  bool? isGetBoardingContent;

  getBoardingData() {
    isGetBoardingContent = false;
    emit(GetBoardingDataLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetBoardingContent)
        .then((value) {
      print(value.data);
      boardingContentModel = BoardingContentModel.fromJson(value.data);
      emit(GetBoardingDataSuccessState());
      isGetBoardingContent = true;
    }).catchError((error) {
      print(error.toString());
      isGetBoardingContent = false;
      emit(GetBoardingDataErrorState(error: error.toString()));
    });
  }

  late AccountTypeModel accountTypeModel;
  bool? isGetAccountType;

  getAccountType() {
    isGetAccountType = false;
    emit(GetAccountTypeDataLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.GetAccountTypeContent)
        .then((value) {
      print(value.data);
      accountTypeModel = AccountTypeModel.fromJson(value.data);
      emit(GetAccountTypeDataSuccessState());
      isGetAccountType = true;
    }).catchError((error) {
      print(error.toString());
      isGetAccountType = false;
      emit(GetAccountTypeDataErrorState(error: error.toString()));
    });
  }
}
