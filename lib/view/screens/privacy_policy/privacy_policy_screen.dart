import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../bloc/setting_cubit/terms_cubit/cubit.dart';
import '../../../../../bloc/setting_cubit/terms_cubit/state.dart';
import '../../../../../view/base/auth_header.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/dimention.dart';
import '../../base/shimmer/contact_us_shimmer.dart';
import '../../base/show_toast.dart';
import '../../error_widget/error_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var termsAndConditionCubit = context.read<TermsAndConditionCubit>();
    return Scaffold(
     // appBar: AuthHeader(title: LocaleKeys.privacyPolicy.tr()),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.privacyPolicy.tr()),
          ),
          Expanded(
            child: BlocBuilder<TermsAndConditionCubit, TermsAndConditionState>(
              builder: (context, state) {
                if (state is GetTermsAndConditionLoadingState) {
                  return ContactUsShimmer();
                }
                return state is GetTermsAndConditionErrorState
                    ? CustomErrorWidget(reload: () {
                        termsAndConditionCubit.getTermsAndCondition();
                      })
                    : Padding(
                        padding:const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        child: SingleChildScrollView(
                          child: Html(
                            data: termsAndConditionCubit
                                    .termsAndConditionModel.data?.content ??
                                '',
                            onLinkTap: (link,map,_)async{
                              if(await canLaunchUrl(Uri.parse(link!))){
                                await launchUrl(Uri.parse(link));
                              }else{
                                showCustomSnackBar(
                                  //  context: context,
                                    message:  LocaleKeys.invalidUrl.tr(), state: ToastState.ERROR);
                                // throw;
                              }

                            } ,
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
