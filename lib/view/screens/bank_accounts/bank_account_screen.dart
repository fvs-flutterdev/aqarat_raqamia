import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:flutter/cupertino.dart';

import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/text_style.dart';
import '../../../../view/base/auth_header.dart';
import '../../../../view/base/shimmer/contact_us_shimmer.dart';
import '../../../../view/error_widget/error_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/setting_cubit/bank_account_cubit/cubit.dart';
import '../../../bloc/setting_cubit/bank_account_cubit/state.dart';

class BankAccountsScreen extends StatelessWidget {
  const BankAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bankAccountsCubit = context.read<BankAccountCubit>();
    return Scaffold(
    //  appBar: AuthHeader(title:LocaleKeys.bankAccounts.tr()),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child:AuthHeader(
              title:LocaleKeys.bankAccounts.tr(),
            ),
          ),
          Expanded(
            child: BlocBuilder<BankAccountCubit, BankAccountsState>(
              builder: (context, state) {
                if (state is GetBankAccountsLoadingState) {
                  return ContactUsShimmer();
                } else if (state is GetBankAccountsErrorState) {
                  return CustomErrorWidget(
                    reload: () {
                      bankAccountsCubit.getBankAccountsData();
                    },
                  );
                } else {
                  return Padding(
                    padding:  EdgeInsets.all(12.0.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          '* ${bankAccountsCubit.bankAccountModel.message}',
                          presetFontSizes: [12.sp, 10.sp, 8.sp],
                          style: openSansExtraBold.copyWith(color: darkGreyColor),
                        ),
                        // Html(data: bankAccountsCubit.bankAccountModel.message),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Html(data: bankAccountsCubit.bankAccountModel.data)
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
