import     'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../../utils/text_style.dart';

//ignore: must_be_immutable
class AdvertiserCard extends StatefulWidget {
  String image;
  String name;
  String phone;
  bool isProvider;

  AdvertiserCard({
    super.key,
    required this.name,
    required this.image,
    required this.phone,
    this.isProvider = false,
  });

  @override
  State<AdvertiserCard> createState() => _AdvertiserCardState();
}

class _AdvertiserCardState extends State<AdvertiserCard>
    with TickerProviderStateMixin {
  double _dragPosition = 0;
  double _widgetPosition = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _dragPosition = 0;
      },
      onPanUpdate: (details) {
        setState(() {
          _dragPosition += details.delta.dx;
          _widgetPosition = _dragPosition;
          if (_dragPosition > 50) {
            _animationController.forward(); // Start the animation
          } else {
            _animationController.reverse(); // Reverse the animation
          }
        });
      },
      onPanEnd: (details) {
        if (_dragPosition > 100) {
          launchWhatsapp(context: context, phone: widget.phone);
        } else {
          setState(() {
            _widgetPosition = 0;
            _dragPosition = 0;
            _animationController.reverse();
          });
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(_widgetPosition, 0),
            child: child,
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE)),
          child: Container(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: context.width * 0.04.sp),
            height: context.width * .25.sp,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE)),
            child: Center(
              child: Row(
                children: [
                  ClipOval(
                    child: CircleAvatar(
                        radius: 25.sp,
                        backgroundColor: Colors.transparent,
                        child: FancyShimmerImage(
                          // fit: BoxFit.fill,
                          imageUrl: widget.image,
                          errorWidget: Image.network(Images.AVATAR_IMAGE),
                        )),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Expanded(
                      child: AutoSizeText(
                    widget.name,
                    style: openSansExtraBold.copyWith(color: darkGreyColor),
                    presetFontSizes: [12.sp, 10.sp, 8.sp],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                  // SizedBox(width: context.width,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            launchWhatsapp(
                                context: context, phone: widget.phone);
                          },
                          child: SvgPicture.asset(
                              Images.Whatsapp_Contact_Ads_Svg)),
                      SizedBox(
                        width: 20.sp,
                      ),
                      GestureDetector(
                          onTap: () {
                            launchCall(
                                context: context, phoneNumber: widget.phone);
                          },
                          child: SvgPicture.asset(Images.CALL_SVG)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return  Draggable(
    //   axis: Axis.horizontal,
    //
    //   feedback: Container(color: darkGreysColor,height: context.width*.25.sp,),
    //   childWhenDragging: Container(color: darkGreysColor,height: context.width*.25.sp,),
    //   onDragEnd: (onDragEnd){
    //     launchWhatsapp(context: context, phone: widget.phone);
    //     print('object');
    //   },
    //   affinity: Axis.horizontal,
    //   child: Card(
    //     shape: RoundedRectangleBorder(
    //         borderRadius:
    //         BorderRadius.circular(Dimensions.RADIUS_LARGE)),
    //     child: Container(
    //       padding: EdgeInsetsDirectional.symmetric(horizontal: context.width*0.04.sp),
    //       height: context.width*.25.sp,
    //       decoration: BoxDecoration(
    //           color: whiteColor,
    //           borderRadius:
    //           BorderRadius.circular(Dimensions.RADIUS_LARGE)),
    //       child: Center(
    //         child: Row(
    //           children: [
    //             ClipOval(
    //               child: CircleAvatar(
    //                   radius: 25.sp,
    //                   backgroundColor: Colors.transparent,child:FancyShimmerImage(
    //                 // fit: BoxFit.fill,
    //                 imageUrl: widget.image,  errorWidget:
    //               Image.network(Images.AVATAR_IMAGE),)),
    //             ),
    //             SizedBox(width: 10.sp,),
    //             Expanded(child: AutoSizeText(widget.name,style: openSansExtraBold.copyWith(color: darkGreyColor),presetFontSizes: [12.sp,10.sp,8.sp],maxLines: 2,overflow: TextOverflow.ellipsis,)),
    //            // SizedBox(width: context.width,),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 GestureDetector( onTap: (){
    //                   launchWhatsapp(context: context, phone: widget.phone);
    //                 },child: SvgPicture.asset(Images.Whatsapp_Contact_Ads_Svg)),
    //                 SizedBox(width: 20.sp,),
    //                 GestureDetector( onTap: (){
    //                   launchCall(context: context, phoneNumber: widget.phone);
    //                 },child: SvgPicture.asset(Images.CALL_SVG)),
    //               ],
    //             )
    //
    //             // ListTile(
    //             //   leading: ClipOval(
    //             //     child: CircleAvatar(
    //             //         radius: 25.sp,
    //             //         backgroundColor: Colors.transparent,child:FancyShimmerImage(
    //             //          // fit: BoxFit.fill,
    //             //           imageUrl: image,  errorWidget:
    //             //     Image.network(Images.AVATAR_IMAGE),)),
    //             //   ),
    //             //   title: AutoSizeText(name,style: openSansExtraBold.copyWith(color: darkGreyColor),presetFontSizes: [12.sp,10.sp,8.sp],maxLines: 2,overflow: TextOverflow.ellipsis,),
    //             //   subtitle: AutoSizeText(subtitle??'',style: openSansRegular.copyWith(color: whiteGreyColor),presetFontSizes: [12.sp,10.sp,8.sp],maxLines: 2,overflow: TextOverflow.ellipsis,),
    //             //
    //             //
    //             //   trailing:SizedBox(
    //             //     width: context.width*0.15.sp,
    //             //     child: Row(
    //             //       mainAxisAlignment: MainAxisAlignment.end,
    //             //       children: [
    //             //         GestureDetector( onTap: (){
    //             //           launchWhatsapp(context: context, phone: phone);
    //             //         },child: SvgPicture.asset(Images.Whatsapp_Contact_Ads_Svg)),
    //             //         SizedBox(width: 10.sp,),
    //             //         GestureDetector( onTap: (){
    //             //           launchCall(context: context, phoneNumber: phone);
    //             //         },child: SvgPicture.asset(Images.CALL_SVG)),
    //             //       ],
    //             //     ),
    //             //   ) ,
    //             // ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
