import 'dart:developer';
import 'package:aqarat_raqamia/bloc/summary_bloc/state.dart';
import 'package:aqarat_raqamia/model/dynamic_model/summary/provider_summary_model.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:bloc/bloc.dart';
import '../../model/dynamic_model/summary/client_summary_model.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit() : super(InitialSummaryState());

  late ProviderSummaryModel providerSummaryModel;
  late ClientSummaryModel clientSummaryModel;

  getSummary() {
    emit(GetSummaryLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.Summary,
        token: token)
       // token:
    //"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Rhc2hib2FyZC5yZWRkLnNhL2FwaS9hdXRoL2NoZWNrT3RwIiwiaWF0IjoxNzMzMzc5NTIzLCJleHAiOjE5ODI1NTM5NTIzLCJuYmYiOjE3MzMzNzk1MjMsImp0aSI6InRHQXV5dmJHU2Mya0lBQ2oiLCJzdWIiOiIzMDgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.wOp_Vqd2DvU7RQ6wanUI0o9TVLDFU0JQvi7R2pyWy4A")
        .then((value) {
      log(value.data.toString());
      if(accountType=="service_provider"){
        providerSummaryModel = ProviderSummaryModel.fromJson(value.data);
      }else{
        clientSummaryModel=ClientSummaryModel.fromJson(value.data);
      }
      emit(GetSummarySuccessState());
    }).catchError((error)
    {
      log(error.toString());
      emit(GetSummaryErrorState(error: error.toString()));
    }
    );
  }
}
