import '../../utils/images.dart';

class AccountTypeModel {
  int id;
  String title;
  bool isTabbed;

  AccountTypeModel({required this.id,
    required this.title,required this.isTabbed});
}

List<AccountTypeModel> accountList = [
  AccountTypeModel(
      id: 1,
    isTabbed:false,
      // image: Images.ACCOUNT_TYPE_CLIENT,
      title: 'طالب خدمه',
  ),
      AccountTypeModel(
      id: 2,
        isTabbed:false,
      title: 'مزود خدمه',)
];
