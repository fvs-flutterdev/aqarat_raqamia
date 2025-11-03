import 'package:flutter/cupertino.dart';

import '../../../utils/media_query_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/setting_cubit/complaint_cubit/cubit.dart';
import '../../../bloc/setting_cubit/complaint_cubit/state.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../utils/text_style.dart';
import '../../base/adaptive_dialog_loader.dart';
import '../../base/auth_header.dart';
import '../../base/custom_text_field.dart';
import '../../base/main_button.dart';

class AddCompalint extends StatefulWidget {
  const AddCompalint({super.key});

  @override
  State<AddCompalint> createState() => _AddCompalintState();
}

class _AddCompalintState extends State<AddCompalint>
    with TickerProviderStateMixin {
  late ComplaintCubit complaintCubit;
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    complaintCubit = context.read<ComplaintCubit>();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AuthHeader(title: LocaleKeys.MakingComplaint.tr()),
      body: Column(
        children: [
          Container(
            height: context.height * 0.17.h,
            margin: EdgeInsets.zero,
            child: AuthHeader(title: LocaleKeys.MakingComplaint.tr()),
          ),
          Expanded(
            child: BlocConsumer<ComplaintCubit, ComplaintState>(
              listener: (context, state) {
                if (state is PostComplaintLoadingState) {
                  return adaptiveDialogLoader(context: context);
                } else if (state is PostComplaintErrorState) {
                  Navigator.pop(context);
                } else if (state is PostComplaintSuccessState) {
                  emailController.clear();
                  descriptionController.clear();
                  subjectController.clear();
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            labelText: LocaleKeys.email.tr(),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (String value) {
                              if (!value.contains('@')) {
                                return LocaleKeys.containAt.tr();
                              } else if (value.isEmpty || value.length < 5) {
                                return LocaleKeys.containFive.tr();
                              }
                            },
                          ),
                          CustomTextField(
                            labelText: LocaleKeys.subject.tr(),
                            controller: subjectController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return LocaleKeys.subjectComplaint.tr();
                              }
                            },
                          ),
                          CustomTextField(
                              controller: descriptionController,
                              labelText: LocaleKeys.description.tr(),
                              minHeight: context.height * 0.1.sp,
                              maxHeight: context.height * 0.13.sp,
                              // focusNode: FocusScope.of(context).unfocus(),
                              // focusNode:,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return LocaleKeys.descriptionComplaint.tr();
                                }
                              },
                              lines: 10),
                          const Spacer(),
                          CustomButton(
                            textButton: LocaleKeys.send.tr(),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                complaintCubit.postYourComplaint(
                                    context: context,
                                    subject: subjectController.text,
                                    email: emailController.text,
                                    description: descriptionController.text);
                                FocusScope.of(context).unfocus();
                              }
                            },
                            color: goldColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
