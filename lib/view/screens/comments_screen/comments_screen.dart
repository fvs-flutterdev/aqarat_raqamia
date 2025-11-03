import 'package:aqarat_raqamia/bloc/ads_by_id_cubit/state.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/auth_header.dart';
import 'package:aqarat_raqamia/view/screens/comments_screen/widget/list_tile_comment_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../bloc/comments_cubit/cubit.dart';
import '../../../bloc/comments_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/images.dart';
import '../../../utils/text_style.dart';
import '../../base/custom_text_field.dart';

class CommentsScreen extends StatelessWidget {
  final String adId;
  final List model;
      //name, imageUrl, review;
 // final double rate;
  final TextEditingController commentController;

  const CommentsScreen({
    super.key,
    required this.adId,
    required this.model,
    // required this.name,
    // required this.imageUrl,
    // required this.review,
  //  required this.rate,
    required this.commentController,
  });

  @override
  Widget build(BuildContext context) {
    var commentsCubit = context.read<CommentsCubit>();
    var adsByIdCubit = context.read<AdyByIdCubit>();
    return Scaffold(
      // appBar: AuthHeader(
      //   title: '${LocaleKeys.adComments.tr()}${adId}',
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child:AuthHeader(
              title: '${LocaleKeys.adComments.tr()}${adId}',
            ),
          ),
          Expanded(
            child: BlocBuilder<AdyByIdCubit, AdsByIdState>(
              builder: (context, state) {
                return Column(
                  children: [
                     Expanded(
                            child:model.isEmpty
                                ? Center(
                                child: Padding(
                                  padding:  EdgeInsetsDirectional.only(bottom: context.height*0.04),
                                  child: Text(

                                    LocaleKeys.noComments.tr(),
                                    style: openSansBold.copyWith(color: goldColor,),
                                  ),
                                ))
                                : ListView.builder(
                              itemBuilder: (context, index) {
                                return ListTileCommentWidget(
                                  imageUrl: model[index].image ??
                                      Images.AVATAR_IMAGE,
                                  commentId:model[index].id??0 ,
                                  name: model[index].name ??
                                      '',
                                  review:model[index].content ??
                                      '',
                                  rate: model[index].averageRate!,
                                );
                              },
                              itemCount:
                                  model.length,
                            ),
                          ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 8.0, start: 10.sp, end: 10.sp),
                      child: CustomTextField(
                        labelText: LocaleKeys.addComment.tr(),
                        controller: commentController,
                        onSubmit: (text) {
                          commentsCubit
                              .postCommentForAd(
                                  adId: adId, commentContent: commentController.text)
                              .then((value) => commentController.clear());
                          adsByIdCubit.getAdById(id: int.parse(adId));
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
