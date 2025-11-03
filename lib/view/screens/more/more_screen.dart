import '../../../bloc/setting_cubit/logout_cubit/cubit.dart';
import '../../../bloc/setting_cubit/logout_cubit/state.dart';
import '../../../model/static_model/more_model.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/dimention.dart';
import '../../../utils/images.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/auth_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../translation/locale_keys.g.dart';
import '../../base/adaptive_dialog_loader.dart';
import '../../base/main_button.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var logoutCubit = context.read<LogoutCubit>();
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
                height: context.height * 0.17.sp,
                margin: EdgeInsets.zero,
                child: AuthHeader(
                  isCanBack: false,
                  title: LocaleKeys.menu.tr(),
                )),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: moreList.length + 1,
                    itemBuilder: (context, index) {
                      return index == 16
                          ? Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_LARGE),
                              child:
                             token == null
                                      ? const SizedBox()
                                      : CustomButton(
                                          onPressed: () {
                                            logoutCubit.logout(context);
                                          },
                                          textButton: LocaleKeys.logOut.tr(),
                                          color: darkGreyColor,
                                        ),
                            )
                          : Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              height: context.width * 0.2.h,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_LARGE),
                              ),
                              child: Center(
                                child: ListTile(
                                  onTap: () {
                                    moreList[index].onPressed();
                                  },
                                  leading: SvgPicture.asset(
                                      moreList[index].svgIcon,
                                      height: 25.sp),
                                  title: Text(
                                    moreList[index].title.tr(),
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
              height: Dimensions.PADDING_SIZE_OVER_LARGE * 1.5.sp,
            )
          ],
        );
      },
    );
  }
}
