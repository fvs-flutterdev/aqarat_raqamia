
import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';

class CustomAlertDialog extends StatelessWidget {
  final Function pickGallery;
  final Function pickCamera;

  const CustomAlertDialog(
      {super.key, required this.pickGallery, required this.pickCamera});

  @override
  Widget build(BuildContext context) {
    // var registerCubit=RegisterCubit.get(context);
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text(LocaleKeys.selectPhoto.tr(),style:openSansExtraBold.copyWith(color: redColor)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: context.width*0.05,vertical:context.height*0.01 ),
                    child: GestureDetector(
                      onTap: (){ pickCamera();},
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: darkGreyColor,
                          ),
                          SizedBox(width: context.width*0.02,),
                          Text(LocaleKeys.camera.tr(),style: openSansRegular,),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: context.width*0.05,vertical: context.width*0.01),
                    child: GestureDetector(

                      onTap: (){pickGallery();},
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: goldColor,
                          ),
                          SizedBox(width: context.width*0.02,),
                          Text(LocaleKeys.gallery.tr(),style: openSansRegular,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        },
        child: Image.asset(Images.CAMERA_ALT,
            width: 50.w, height: 50.h, alignment: Alignment.center),
      ),
    );
  }
}
