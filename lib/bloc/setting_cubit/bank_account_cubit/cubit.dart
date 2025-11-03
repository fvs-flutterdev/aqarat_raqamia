import 'package:aqarat_raqamia/bloc/setting_cubit/bank_account_cubit/state.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/dynamic_model/get_account_bank_numbers.dart';

class BankAccountCubit extends Cubit<BankAccountsState> {
  BankAccountCubit() : super(InitialBankAccountsState());

  late BankAccountModel bankAccountModel;

  getBankAccountsData() {
    emit(GetBankAccountsLoadingState());
    DioHelper.getData(url: BaseUrl.baseUrl + BaseUrl.BankAccounts)
        .then((value) {
      print(value.data);
      bankAccountModel = BankAccountModel.fromJson(value.data);
      emit(GetBankAccountsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBankAccountsErrorState(error: error.toString()));
    });
  }
}
