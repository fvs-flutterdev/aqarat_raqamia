import 'package:flutter/cupertino.dart';

import '../../../../../utils/media_query_value.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../view/screens/providers/provider_profile/widget/gallery_image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/profile_cubit/cubit.dart';
import '../../../../bloc/profile_cubit/state.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../base/auth_header.dart';
import '../../../base/custom_text_field.dart';
import '../../../base/row_widget_image.dart';
import '../my_orders/widget/current_order_widget.dart';

//ignore: must_be_immutable
class ProviderDetailsScreen extends StatelessWidget {
  String? name;
  String? imageAvatar;
  double? noRate;
  String? rate;
  TextEditingController? value;
  TextEditingController? notes;
  TextEditingController? visionary;
  TextEditingController? objectives;
  List<String>? projects;
  List<String>? achievements;
  List<String>? images_album;
  String? id;

  ProviderDetailsScreen(
      {super.key,
      this.value,
      this.name,
      this.rate,
      this.notes,
      this.objectives,
      this.visionary,
      this.noRate,
      this.imageAvatar,
      this.achievements,
      this.projects,
        this.id,
      this.images_album});

  @override
  Widget build(BuildContext context) {
    var profileCubit = context.read<ProfileCubit>();
    return Scaffold(
     // appBar: AuthHeader(),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(context.width * 0.06),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInfoWidget(
                      rate: rate.toString(),
                      isPending: false,
                      id:int.parse(id??'0'),
                      isPrevious: true,
                      isUser: false,
                      name: name ?? '',
                      image: imageAvatar ?? '',
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.notesAboutYou.tr(),
                      isBig: true,
                      lines: 5,
                      controller: notes,
                      maxHeight: context.width * 0.39,
                      minHeight: context.width * 0.39,
                      isEnabled: false,
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.vision.tr(),
                      isBig: true,
                      lines: 5,
                      controller: visionary,
                      maxHeight: context.width * 0.39,
                      minHeight: context.width * 0.39,
                      isEnabled: false,
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.value.tr(),
                      isBig: true,
                      controller: value,
                      isEnabled: false,
                      lines: 5,
                      maxHeight: context.width * 0.39,
                      minHeight: context.width * 0.39,
                    ),
                    CustomTextField(
                      labelText: LocaleKeys.Objectives.tr(),
                      isBig: true,
                      isEnabled: false,
                      controller: objectives,
                      lines: 5,
                      maxHeight: context.width * 0.39,
                      minHeight: context.width * 0.39,
                    ),
                    BlocConsumer<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return RowWidgetImage(
                          isPdfFile: true,
                          isProviderProfile: true,
                          list: projects,
                          title: LocaleKeys.projects.tr(),
                          isListEmpty: profileCubit.selectedProjectsFilePdf.isEmpty,
                          clearFun: () => profileCubit.clearProjectsImage(),
                        );
                      },
                    ),
                    projects!.isEmpty
                        ? Text(
                            LocaleKeys.noData.tr(),
                            style: openSansMedium.copyWith(color: darkGreyColor),
                          )
                        : Container(
                            child: FirstImageInProviderProfile(
                              isPdfFile: true,
                              imageUrl: projects ?? [],
                            ),
                          ),
                    SizedBox(
                      height: 10.h,
                    ),

                    ///
                    BlocConsumer<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return RowWidgetImage(
                          isProviderProfile: true,
                          list: achievements,
                          title: LocaleKeys.achievements.tr(),
                          isListEmpty: profileCubit.selectedAchievementsPdf.isEmpty,
                          isPdfFile: true,
                          // isListEmpty:
                          //     profileCubit.selectedAchievementsImages.isEmpty,
                          clearFun: () => profileCubit.clearPickAchievementsImage(),
                        );
                      },
                    ),
                    achievements!.isEmpty
                        ? Text(
                            LocaleKeys.noData.tr(),
                            style: openSansMedium.copyWith(color: darkGreyColor),
                          )
                        : Container(

                            child: FirstImageInProviderProfile(
                                isPdfFile: true,
                                imageUrl: achievements ?? []),
                          ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BlocConsumer<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return RowWidgetImage(
                          isProviderProfile: true,
                          // images: ,
                          list: images_album,
                          title: LocaleKeys.albumImages.tr(),
                          isListEmpty: profileCubit.selectedAlbumImages.isEmpty,
                          clearFun: () => profileCubit.clearAlbumImage(),
                        );
                      },
                    ),
                    images_album!.isEmpty
                        ? Text(
                            LocaleKeys.noData.tr(),
                            style: openSansMedium.copyWith(color: darkGreyColor),
                          )
                        : Container(
                            child: FirstImageInProviderProfile(
                              imageUrl: images_album ?? [],
                            ),
                          ),
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
