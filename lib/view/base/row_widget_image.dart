import 'package:aqarat_raqamia/bloc/profile_cubit/cubit.dart';
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pdf_widgets/pdf_url.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/dimention.dart';
import '../../utils/text_style.dart';
import '../screens/pdf_view/pdf_view.dart';
import 'full_screen_image/full_screen_image.dart';
import 'lunch_widget.dart';

class RowWidgetImage extends StatelessWidget {
  bool? isListEmpty;
  Function? clearFun;
  String? title;
  String? subTitle;
  bool? isPdfFile;

  //String? noText;
  bool? isProviderProfile;
  List? list;

  // String? images;
  RowWidgetImage(
      {super.key,
      this.isListEmpty,
      this.clearFun,
      this.title,
      this.subTitle,
      this.isProviderProfile,
      this.list,
      this.isPdfFile = false
      //this.noText
      // this.images
      });

  @override
  Widget build(BuildContext context) {
    var profileCubit = context.read<ProfileCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: openSansBold.copyWith(color: goldColor),
            children: [
              TextSpan(
                  text: subTitle == null ? null : ' "$subTitle"',
                  style: openSansMedium.copyWith(
                      color: darkGreyColor, fontSize: 10))
            ],
          ),
        ),
        isProviderProfile == true
            ? list!.isEmpty
                ? SizedBox()
                : TextButton(
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: context.width * 0.04),
                              height: context.height * 0.8,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: transparentColor,
                                          )),
                                      Text(
                                        title ?? '',
                                        style: openSansBold.copyWith(
                                            color: darkGreyColor),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: redColor,
                                          ))
                                    ],
                                  ),
                                  Expanded(
                                    child: GridView.builder(
                                        itemCount: list?.length,
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 1 / 1.4),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                if (isPdfFile == true) {
                                                  navigateForward(PdfViewScreen(
                                                      url: list![index],
                                                      title: list![index]
                                                          .substring(55)));
                                                  // launchUrlSocial(imageUrl[index]);
                                                  //launchUrl(Uri());
                                                } else {
                                                  navigateForward(
                                                      FullImageListScreen(
                                                    image: list!,
                                                    itemCount: list!.length,
                                                  ));
                                                }
                                              },
                                              child: Container(
                                                height: context.width * 0.5,
                                                width: context.width * 0.24,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: goldColor),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            Dimensions
                                                                .RADIUS_DEFAULT))),
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                  end: context.width * 0.02,
                                                  bottom: context.width * 0.02,
                                                ),
                                                child: ClipRRect(
                                                    // clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .RADIUS_DEFAULT),
                                                    child: isPdfFile == false
                                                        ? Image.network(
                                                            list![index],
                                                            fit: BoxFit.cover,
                                                          )
                                                        :
                                                        //list![index].toString().endsWith('.pdf')?
                                                        Stack(
                                                            children: [
                                                              PDFThumbnailWidget(
                                                                pdfUrl: list![
                                                                    index],
                                                              ),
                                                              Container(
                                                                color: whiteGreyColor
                                                                    .withOpacity(
                                                                        0.1),
                                                              )
                                                            ],
                                                          )
                                                    //:
                                                    //   Image.asset(
                                                    //           Images.PDFImage),
                                                    // ),
                                                    ),
                                              ));
                                        }),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Text(
                      '${LocaleKeys.more.tr()}>>',
                      style: openSansRegular.copyWith(
                          decoration: TextDecoration.underline),
                    ))
            : IconButton(
                onPressed: () {
                  clearFun!();
                },
                icon: Icon(
                  Icons.clear,
                  color: redColor,
                )),
        //    isListEmpty==true
        // // uploadRequestCubit.selectedImages.isEmpty
        //       ? SizedBox()
        //       :  IconButton(
        //       onPressed: () {
        //         clearFun!();
        //      //   uploadRequestCubit.clearImage();
        //       },
        //       icon: Icon(
        //         Icons.clear,
        //         color: redColor,
        //       ))
      ],
    );
  }
}
