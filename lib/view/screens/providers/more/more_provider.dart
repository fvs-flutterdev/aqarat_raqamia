import '../../../../../bloc/setting_cubit/logout_cubit/cubit.dart';
import '../../../../../bloc/setting_cubit/logout_cubit/state.dart';
import '../../../../../model/static_model/more_model.dart';
import '../../../../../pusher_config/pusher.dart';
import '../../../../../utils/dimention.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/media_query_value.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../view/base/adaptive_dialog_loader.dart';
import '../../../../../view/base/auth_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/app_constant.dart';
import '../../../base/main_button.dart';

class MoreProviderScreen extends StatelessWidget {
  const MoreProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogOutLoadingState) {
          adaptiveDialogLoader(context: context);
        } else if (state is LogOutErrorState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Container(
                // margin:
                // EdgeInsets.only(bottom: context.height * 0.01.sp),
                height: context.height * 0.17.h,
                child: AuthHeader(
                  isCanBack: false,
                  title: LocaleKeys.menu.tr(),
                )),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: moreListProviders.length + 1,
                    itemBuilder: (context, index) {
                      return index == 17
                          ? Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              child:
                              // state is LogOutLoadingState
                              // ? Center(child: CircularProgressIndicator()):
                              CustomButton(
                                onPressed: () {
                                  context.read<LogoutCubit>().logout(context);
                                },
                                textButton: LocaleKeys.logOut.tr(),
                                color: darkGreyColor,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              height: context.height * 0.08,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_LARGE),
                              ),
                              child: Center(
                                child: ListTile(
                                  onTap: () {
                                    if (index == 2) {
                                      LaravelEcho.init(token: token);
                                      moreListProviders[2].onPressed();
                                    } else {
                                      moreListProviders[index].onPressed();
                                    }
                                  },
                                  leading: SvgPicture.asset(
                                      moreListProviders[index].svgIcon,
                                      height: 20.sp),
                                  title: Text(
                                    moreListProviders[index].title.tr(),
                                    style: openSansMedium.copyWith(
                                        color: darkGreyColor),
                                  ),
                                  trailing: myLocale.toString() == 'ar'
                                      ? SvgPicture.asset(Images.ARROW_SVG)
                                      : Icon(
                                          Icons.arrow_forward_ios,
                                          color: darkGreyColor,
                                          size: 15.sp,
                                        ),
                                ),
                              ),
                            );
                    })),
            SizedBox(
              height: Dimensions.PADDING_SIZE_OVER_LARGE*1.5.sp,
            )
          ],
        );
      },
    );
  }
}
