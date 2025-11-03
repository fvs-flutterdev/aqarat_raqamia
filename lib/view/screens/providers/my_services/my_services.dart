import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/profile_cubit/cubit.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../view/base/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/auth_cubit/auth_provider/cubit.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../base/auth_header.dart';
import 'edit_service.dart';

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  @override
  void initState() {
    context.read<RegisterProviderCubit>().getProfileServices(context);
    context.read<RegisterProviderCubit>().getSubServicesById();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title: LocaleKeys.myServices.tr(),
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(
              title: LocaleKeys.myServices.tr(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(context.width * 0.02),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //  sadkjh
                      LocaleKeys.mainServices.tr(),
                      style: openSansBold.copyWith(color: darkGreyColor),
                    ),
                    SizedBox(
                      height: context.width * 0.03,
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: profileCubit
                              .profileModel.userProfile!.services!.length,
                          itemBuilder: (context, index) {
                            return CustomTextField(
                              labelText: LocaleKeys.service.tr(),
                              isEnabled: false,
                              controller: TextEditingController(
                                text: profileCubit.profileModel.userProfile!
                                    .services![index].name,
                              ),
                            );
                          }),
                    ),
                    Text(
                      LocaleKeys.subServices.tr(),
                      style: openSansBold.copyWith(color: darkGreyColor),
                    ),
                    SizedBox(
                      height: context.width * 0.03,
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: profileCubit
                              .profileModel.userProfile!.subServices!.length,
                          itemBuilder: (context, index) {
                            return CustomTextField(
                              labelText: LocaleKeys.service.tr(),
                              isEnabled: false,
                              controller: TextEditingController(
                                  text: profileCubit.profileModel.userProfile!
                                      .subServices![index].name),
                            );
                          }),
                    ),
                    CustomButton(
                        color: darkGreysColor,
                        textButton: LocaleKeys.updateMyServices.tr(),
                        onPressed: () {
                          navigateForward(EditService());
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
