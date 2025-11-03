
import 'package:aqarat_raqamia/utils/dimention.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc/setting_cubit/about_us_cubit/cubit.dart';
import '../../../bloc/setting_cubit/about_us_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../base/auth_header.dart';
import '../../base/shimmer/contact_us_shimmer.dart';
import '../../base/show_toast.dart';
import '../../error_widget/error_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var aboutUsCubit = context.read<AboutUsCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title:LocaleKeys.aboutUs.tr(),
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child:AuthHeader(
              title:LocaleKeys.aboutUs.tr(),
            ),
          ),
          Expanded(
            child: BlocBuilder<AboutUsCubit, AboutUsState>(
              builder: (context, state) {
                if (state is GetAboutUsLoadingState) {
                  return ContactUsShimmer();
                }
                return state is GetAboutUsErrorState
                    ? CustomErrorWidget(reload: () {
                        aboutUsCubit.getAboutUsData();
                      })
                    : Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        child: SingleChildScrollView(
                          child: Html(
                            data: aboutUsCubit.aboutUsModel.data?.data?.content ?? '',
                            onLinkTap: (link, map, _) async {
                              if (await canLaunch(link!)) {
                                await launch(link);
                              } else {
                                showCustomSnackBar(
                                   // context: context,
                                    message:LocaleKeys.invalidUrl.tr(),
                                    state: ToastState.ERROR);
                                // throw;
                              }
                            },
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
