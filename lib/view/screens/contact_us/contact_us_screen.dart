import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/setting_cubit/contact_us_cubit/cubit.dart';
import '../../../bloc/setting_cubit/contact_us_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/dimention.dart';
import '../../../utils/images.dart';
import '../../../utils/media_query_value.dart';
import '../../../view/base/auth_header.dart';
import '../../../view/error_widget/error_widget.dart';
import '../../../view/screens/contact_us/widget/contact_us_widget.dart';
import '../../base/lunch_widget.dart';
import '../../base/shimmer/contact_us_shimmer.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var contactUsCubit = context.read<ContactUsCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title: LocaleKeys.contactUs.tr(),
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.contactUs.tr()),
          ),
          Expanded(
            child: BlocBuilder<ContactUsCubit, ContactUsState>(
              builder: (context, state) {
                if (state is GetContactUsDataLoadingState) {
                  return ContactUsShimmer();
                }
                return state is GetContactUsDataErrorState
                    ? CustomErrorWidget(reload: () {
                        contactUsCubit.getContactInfo();
                      })
                    : Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          children: [
                            ContactUsWidget(
                              fct: () {
                                launchCall(
                                    context: context,
                                    phoneNumber: contactUsCubit.contactUsModel
                                            .data?.content?.phone ??
                                        '');
                              },
                              contactInfo: LocaleKeys.phoneCall.tr(),
                              svgPic: Images.CALL_CONTACT_US,
                            ),
                            SizedBox(
                              height: context.height * 0.018.sp,
                            ),
                            ContactUsWidget(
                              fct: () {
                                launchWhatsapp(
                                  context: context,
                                  phone: contactUsCubit.contactUsModel.data
                                          ?.content?.whatsApp ??
                                      '',
                                );
                              },
                              contactInfo: LocaleKeys.whatsapp.tr(),
                              svgPic: Images.Whats_CONTACT_US,
                            ),
                            SizedBox(
                              height: context.height * 0.018.sp,
                            ),
                            ContactUsWidget(
                              fct: () {
                                navigateToMail(
                                    context: context,
                                    mail: contactUsCubit.contactUsModel.data
                                            ?.content?.mail ??
                                        '');
                              },
                              contactInfo: LocaleKeys.email.tr(),
                              svgPic: Images.MAIL_CONTACT_US,
                            ),
                            SizedBox(
                              height: context.height * 0.018.sp,
                            ),
                            ContactUsWidget(
                              fct: () {
                                launchUrlSocial(contactUsCubit.contactUsModel
                                        .data?.content?.facebook ??
                                    '');
                                // navigateToMail(context: context, mail: contactUsCubit
                                //     .contactUsModel.data?.content?.mail ??
                                //     '');
                              },
                              contactInfo: LocaleKeys.facebook.tr(),
                              svgPic: Images.Meta_Contact_US,
                            ),
                            SizedBox(
                              height: context.height * 0.018.sp,
                            ),
                            ContactUsWidget(
                              fct: () {
                                launchUrlSocial(contactUsCubit.contactUsModel
                                        .data?.content?.instagram ??
                                    '');
                                // navigateToMail(context: context, mail: contactUsCubit
                                //     .contactUsModel.data?.content?.mail ??
                                //     '');
                              },
                              contactInfo: LocaleKeys.instagram.tr(),
                              svgPic: Images.Insta_Contact_US,
                            ),
                            SizedBox(
                              height: context.height * 0.018.sp,
                            ),
                            ContactUsWidget(
                              fct: () {
                                launchUrlSocial(contactUsCubit.contactUsModel
                                        .data?.content?.twitter ??
                                    '');
                                // navigateToMail(context: context, mail: contactUsCubit
                                //     .contactUsModel.data?.content?.mail ??
                                //     '');
                              },
                              contactInfo: LocaleKeys.x.tr(),
                              svgPic: Images.X_Contact_US,
                            ),
                          ],
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
