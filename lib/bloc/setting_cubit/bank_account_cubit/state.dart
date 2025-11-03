abstract class BankAccountsState {}

class InitialBankAccountsState extends BankAccountsState {}

class GetBankAccountsLoadingState extends BankAccountsState {}

class GetBankAccountsSuccessState extends BankAccountsState {}

class GetBankAccountsErrorState extends BankAccountsState {
  final String error;

  GetBankAccountsErrorState({required this.error});
}
