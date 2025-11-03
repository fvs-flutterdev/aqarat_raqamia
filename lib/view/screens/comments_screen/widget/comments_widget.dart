import 'package:aqarat_raqamia/bloc/comments_cubit/cubit.dart';
import 'package:aqarat_raqamia/bloc/comments_cubit/state.dart';
import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../base/custom_text_field.dart';
import '../../home/widget/row_text_widget.dart';
import '../comments_screen.dart';
import 'list_tile_comment_widget.dart';

class CommentsWidget extends StatelessWidget {
  final String adId;
  final List model;

  //name,
  //   imageUrl,
  //  review;
  final double rate;

  CommentsWidget({
    super.key,
    required this.adId,
    required this.rate,
    required this.model,
    //  required this.name,
    // required this.imageUrl,
    // required this.review,
    // required this.commentController,
  });

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var commentsCubit = context.read<CommentsCubit>();
    var adsByIdCubit = context.read<AdyByIdCubit>();
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowMoreWidget(
                text: LocaleKeys.comments.tr(),
                navigation: () {
                  navigateForward(CommentsScreen(
                    model:model ,
                    //adsByIdCubit.adsByIdModel.data!.adComments??[],
                    commentController: commentController,
                    adId: adId,
                    // imageUrl: 'imageUrl',
                    // name: 'name',
                    // review: 'review',
                    // rate: 2.5,
                  ));
                },
              ),
              model.isEmpty
                  ? Center(
                      child: Padding(
                        padding:  EdgeInsetsDirectional.only(bottom: context.height*0.04),
                        child: Text(
                        LocaleKeys.noComments.tr(),
                        style: openSansBold.copyWith(color: goldColor,),
                                            ),
                      ))
                  : Container(
                padding:  EdgeInsetsDirectional.only(bottom: context.height*0.04),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount:
                            model.length <
                                    2
                                ? 1
                                : 2,
                        itemBuilder: (context, index) {
                          return ListTileCommentWidget(

                            imageUrl:model[index].image ??
                                Images.AVATAR_IMAGE,
                            name: model[index].name ??
                                '',
                            review: model[index].content ??
                                '',
                            rate: model[index].averageRate??0.0,
                            commentId: model[index].id??0,
                          );
                        },
                      ),
                    ),
              CustomTextField(
                labelText: LocaleKeys.addComment.tr(),
                controller: commentController,
                onSubmit: (text) {
                  commentsCubit.postCommentForAd(
                          adId: adId, commentContent: commentController.text)
                      .then((value) => commentController.clear());
                  adsByIdCubit.getAdById(id: int.parse(adId));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
