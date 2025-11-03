import 'package:flutter/services.dart';

import '../../utils/dimention.dart';
import '../../utils/media_query_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/images.dart';
import '../../utils/text_style.dart';

class ArabicToEnglishNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Map of Arabic numbers to English numbers
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    String text = newValue.text;

    // Convert Arabic numbers to English numbers
    for (int i = 0; i < arabicNumbers.length; i++) {
      text = text.replaceAll(arabicNumbers[i], englishNumbers[i]);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Function? onTap;
  final int? length;
  final int? lines;
  final double? maxHeight;
  final double? minHeight;
  final double? maxWidth;
  final double? minWidth;
  final Function? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final Function? onSubmit;
  final double? bottomPadding;
  final double? topPadding;
  final bool? secure;
  final bool? autoFocus;
  bool isBig = false;
  bool isEnabled = true;
  Color? backgroundColor;
  TextStyle? style;

  CustomTextField({
    super.key,
    required this.labelText,
    this.hintText,
    this.suffix,
    this.prefixIcon,
    this.controller,
    this.secure,
    this.focusNode,
    this.bottomPadding,
    this.autoFocus,
    this.nextFocus,
    this.onSubmit,
    this.topPadding,
    this.isBig = false,
    this.isEnabled = true,
    this.keyboardType,
    this.backgroundColor,
    this.suffixIcon,
    this.onTap,
    this.length,
    this.lines,
    this.validator,
    this.maxHeight,
    this.minHeight,
    this.maxWidth,
    this.minWidth,
    this.style,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.bottomPadding ?? context.width * 0.03.sp,
          top: widget.topPadding ?? 0),
      child: TextFormField(
        autofocus: widget.autoFocus ?? false,

        controller: widget.controller,
        style: widget.style??openSansRegular.copyWith(color: darkGreyColor),
        focusNode: widget.focusNode,

        onTap: () {
          widget.onTap == null
              ? setState(() {
                  widget.controller?.selection = TextSelection.fromPosition(
                      TextPosition(offset: widget.controller!.text.length));
                })
              : print('');
        },
        onFieldSubmitted: (text) => widget.nextFocus != null
            ? FocusScope.of(context).requestFocus(widget.nextFocus)
            : widget.onSubmit != null
                ? widget.onSubmit!(text)
                : null,
        //   onSubmitted:
        maxLines: widget.lines ?? 1,
        maxLength: widget.length,
        inputFormatters:
        // widget.keyboardType == TextInputType.number ||
        //         widget.keyboardType == TextInputType.phone?
                [
                // Allow only numeric input
               // FilteringTextInputFormatter.digitsOnly,
                // Convert Arabic numbers to English numbers
                ArabicToEnglishNumberFormatter(),
              ],
            //:[],
        decoration: InputDecoration(
          filled: true,
          //<-- SEE HERE
          fillColor: widget.backgroundColor ?? Colors.transparent,
          contentPadding: EdgeInsetsDirectional.only(
              start: context.width * 0.02.sp,
              top: widget.isBig ? context.width * 0.03.sp : 0.0),

          constraints: BoxConstraints(
            minHeight: widget.minHeight ?? context.width * 0.15.sp,
            minWidth: widget.minWidth ?? context.width * 0.95.sp,
            maxHeight: widget.maxHeight ?? context.width * 0.15.sp,
            maxWidth: widget.maxWidth ?? context.width * 0.95.sp,
          ),
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          suffix: widget.suffix,
          labelText: widget.labelText,
          labelStyle: openSansBold.copyWith(color: darkGreyColor),
          hintText: widget.hintText,
          hintStyle: openSansRegular.copyWith(color: darkGreyColor),
          errorStyle: openSansRegular.copyWith(color: redColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: whiteGreyColor),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT.r),
            //  borderRadius: BorderRadius.circular(32),
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(color: whiteGreyColor),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          ),
        ),
        validator: (val) {
          return widget.validator!(val);
        },

        keyboardType: widget.keyboardType,
        obscureText: widget.secure ?? false,
        enabled: widget.isEnabled,
      ),
    );
  }
}

//Saudi flag
class FlagTextField extends StatelessWidget {
  const FlagTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(context.width*0.03),
      //   margin: EdgeInsetsDirectional.only(bottom: context.width * 0.1.sp),
      //  margin: EdgeInsetsDirectional.only(bottom: context.width*0.1),
      // padding: EdgeInsets.zero,
      //  height: context.width * 0.12,
      width: context.width * 0.21.sp,
      constraints: BoxConstraints(
        maxHeight: context.width * 0.13,
        minHeight: context.width * 0.13,
      ),
      // maxHeight: context.width * 0.2.sp,
      // minHeight: context.width * 0.15.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          border: Border.all(color: whiteGreyColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
                start: context.width * 0.02.sp, end: 0),
            child: Text(
              '966+',
              style: openSansRegular.copyWith(color: darkGreysColor),
            ),
          ),
          Expanded(child: Image.asset(Images.Saudia_FLAG))
        ],
      ),
    );
  }
}

//LOCATION CARD
class LocationCard extends StatelessWidget {
  Function? fct;

  LocationCard({super.key, this.fct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fct!();
      },
      child: Container(
        padding: EdgeInsets.all(context.width * 0.03),
        margin: EdgeInsetsDirectional.only(bottom: context.width * 0.06),
        height: context.width * 0.12,
        width: context.width * 0.12,
        decoration: BoxDecoration(
          border: Border.all(color: whiteGreyColor),
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
        ),
        child: SvgPicture.asset(
          Images.Location2,
          width: context.width * 0.04,
          height: context.width * 0.04,
        ),
      ),
    );
  }
}
