import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';

class PartnerWidget extends StatelessWidget {
  String? image;
  String? companyName;
  String? companyDes;
  Widget? child;
   PartnerWidget({super.key,this.companyName,this.image,this.companyDes,this.child});

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(5.sp),
        padding: EdgeInsets.symmetric(horizontal: 5.sp),
        // width: context.width * 0.5.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: blackColor.withOpacity(0.2),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0.sp, vertical: 4.0.sp),
          leading: ClipOval(
            child: CircleAvatar(
              radius: 20.sp,
                backgroundColor: transparentColor,

                child: FancyShimmerImage(
                    imageUrl:image??'',

                 //   partnerSponsorCubit.partnerSponsorModel.data!.posterImage!,
                    errorWidget:
                    Image.network(Images.AVATAR_IMAGE))),
          ),
          title: Text(companyName!
           // partnerSponsorCubit.partnerSponsorModel.data!.namePoster!
            ,style: openSansBold.copyWith(color: whiteColor),),
          subtitle:accountType=='service_applicant'? Text(companyDes!
            //partnerSponsorCubit.partnerSponsorModel.data!.posterDescription!
            ,style: openSansMedium.copyWith(color: whiteColor),):child
        ),
      ),
    );
  }
}
