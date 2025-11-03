import 'package:aqarat_raqamia/utils/images.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/shimmer/ads_shimmer.dart';
import 'package:aqarat_raqamia/view/error_widget/error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../bloc/setting_cubit/complaint_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/media_query_value.dart';
import '../../../utils/text_style.dart';
import '../../../view/base/auth_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/setting_cubit/complaint_cubit/cubit.dart';
import 'add_compalint.dart';
import 'compalint_replys_screen.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState
    extends State<ComplaintScreen> //  with TickerProviderStateMixin
    {
  // late ComplaintCubit complaintCubit;
  // TextEditingController emailController = TextEditingController();
  // TextEditingController subjectController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  // @override
  // void didChangeDependencies() {
  //   complaintCubit = context.read<ComplaintCubit>();
  //   // timerProvider = Provider.of<TimerProvider>;
  //   super.didChangeDependencies();
  // }
  //
  // @override
  // void initState() {
  //   SystemChannels.textInput.invokeMethod('TextInput.hide');
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   subjectController.dispose();
  //   descriptionController.dispose();
  //   emailController.dispose();
  //   // complaintCubit.descriptionController.dispose();
  //   // complaintCubit.subjectController.dispose();
  //   // complaintCubit.emailController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var complaintCubit = context.read<ComplaintCubit>();
    return Scaffold(
    //  appBar: AuthHeader(title: LocaleKeys.complaintsSuggestions.tr()),
      // body: BlocConsumer<ComplaintCubit, ComplaintState>(
      //   listener: (context, state) {
      //     if (state is PostComplaintLoadingState) {
      //       return adaptiveDialogLoader(context: context);
      //     } else if (state is PostComplaintErrorState) {
      //       Navigator.pop(context);
      //     } else if (state is PostComplaintSuccessState) {
      //       emailController.clear();
      //       descriptionController.clear();
      //       subjectController.clear();
      //       FocusScope.of(context).unfocus();
      //       Navigator.pop(context);
      //     }
      //   },
      //   builder: (context, state) {
      //     return GestureDetector(
      //       behavior: HitTestBehavior.opaque,
      //       onTap: () => FocusScope.of(context).unfocus(),
      //       child: Padding(
      //         padding: EdgeInsets.all(8.0.sp),
      //         child: Form(
      //           key: _formKey,
      //           child: Column(
      //             children: [
      //               CustomTextField(
      //                 labelText: LocaleKeys.email.tr(),
      //                 keyboardType: TextInputType.emailAddress,
      //                 controller: emailController,
      //                 validator: (String value) {
      //                   if (!value.contains('@')) {
      //                     return LocaleKeys.containAt.tr();
      //                   } else if (value.isEmpty || value.length < 5) {
      //                     return LocaleKeys.containFive.tr();
      //                   }
      //                 },
      //               ),
      //               CustomTextField(
      //                 labelText: LocaleKeys.subject.tr(),
      //                 controller: subjectController,
      //                 validator: (String value) {
      //                   if (value.isEmpty) {
      //                     return LocaleKeys.subjectComplaint.tr();
      //                   }
      //                 },
      //               ),
      //               CustomTextField(
      //                   controller: descriptionController,
      //                   labelText: LocaleKeys.description.tr(),
      //                   minHeight: context.height * 0.1.sp,
      //                   maxHeight: context.height * 0.13.sp,
      //                 // focusNode: FocusScope.of(context).unfocus(),
      //                  // focusNode:,
      //                   validator: (String value) {
      //                     if (value.isEmpty) {
      //                       return LocaleKeys.descriptionComplaint.tr();
      //                     }
      //                   },
      //                   lines: 10),
      //               Spacer(),
      //               CustomButton(
      //                 textButton: LocaleKeys.send.tr(),
      //                 onPressed: () {
      //                   if (_formKey.currentState!.validate()) {
      //                     complaintCubit.postYourComplaint(
      //                       context: context,
      //                         subject: subjectController.text,
      //                         email: emailController.text,
      //                         description: descriptionController.text);
      //                     FocusScope.of(context).unfocus();
      //                   }
      //                 },
      //                 color: goldColor,
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.complaintsSuggestions.tr()),
          ),
          Expanded(
            child: BlocBuilder<ComplaintCubit, ComplaintState>(
              builder: (context, state) {
                if(state is GetMyComplaintsLoadingState){
                  return AdsShimmer();
                }else if(state is GetMyComplaintsErrorState){
                  return CustomErrorWidget(reload: (){
                    complaintCubit.getMyComplaints();
                  });
                }else{
                  return ListView.builder(

                      itemCount: complaintCubit.myComplaintsModel.complaints!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            navigateForward(ReplayComplaintScreen(index: index,));
                          },
                          child: Container(
                            margin: EdgeInsetsDirectional.only(
                              top: context.height * 0.01.h,
                              start: context.width * 0.04.w,
                              end: context.width * 0.04.w,
                            ),
                            padding: EdgeInsetsDirectional.only(
                              top: context.height * 0.01.h,
                              bottom: context.height * 0.01.h,
                              start: context.width * 0.02.w,
                              end: context.width * 0.1.w,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.sp),
                                border: Border.all(color: goldColor)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(text: TextSpan(text: LocaleKeys.complaintNo.tr(),style: openSansMedium.copyWith(color: blackColor),children: [
                                  TextSpan(text: complaintCubit.myComplaintsModel.complaints![index].id.toString(),style:  openSansMedium.copyWith(color:redColor ),)
                                ]),
                                ),
                                RichText(text: TextSpan(text: LocaleKeys.complaintSubject,style: openSansMedium.copyWith(color: blackColor),children: [
                                  TextSpan(text: complaintCubit.myComplaintsModel.complaints![index].subject.toString(),style: openSansMedium.copyWith(color: redColor),)
                                ]),
                                ),
                                RichText(text: TextSpan(text: '${LocaleKeys.description.tr()}: ',style: openSansMedium.copyWith(color: blackColor),children: [
                                  TextSpan(text: complaintCubit.myComplaintsModel.complaints![index].description.toString(),style: openSansMedium.copyWith(color: redColor),)
                                ]),
                                )
                              //  Text('${LocaleKeys.complaintNo.tr()}#${complaintCubit.myComplaintsModel.complaints![index].id}'),
                              ],
                            ),
                          ),
                        );
                      });
                }

              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateForward(AddCompalint());
        },
        label: Row(
          children: [
            SvgPicture.asset(
              Images.Add_SVG,
              color: whiteColor,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              LocaleKeys.MakingComplaint.tr(),
              style: openSansBold.copyWith(color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
