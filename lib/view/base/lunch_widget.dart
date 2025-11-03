import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/navigation_service.dart';

navigateForward(Widget page, {arguments}) {
  NavigationService.navigate().navigateToScreen(page, arguments: arguments);
}

navigateForwardReplace(Widget page, {arguments}) {
  NavigationService.navigate().replaceScreen(page, arguments: arguments);
}

navigatePop(Widget page, {arguments}) {
  NavigationService.navigate().goBack();
}

logoutNavigation(Widget page) {
  NavigationService.navigate().popToFirst(page);
}

navigateAndRemove(Widget page) {
  NavigationService.navigate().removeScreenUntil(page);
}

launchWhatsapp(
    {required String phone,
    required BuildContext context,
    String? text}) async {
  // var whatsapp = "+966501342728";
  var whatsappAndroid = Uri.parse(
      "whatsapp://send?phone=$phone&text=${text ?? 'هلا معك واتساب خدمات عقارات الرقمية'}");
  if (await canLaunchUrl(whatsappAndroid)) {
    await launchUrl(whatsappAndroid);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(LocaleKeys.whatsNotInstall.tr()),
      ),
    );
  }
}

launchCall({required BuildContext context, required String phoneNumber}) async {
  // var whatsapp = "+966501342728";
  var whatsappAndroid = Uri.parse("tel:$phoneNumber");
  if (await canLaunchUrl(whatsappAndroid)) {
    await launchUrl(whatsappAndroid);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(LocaleKeys.whatsNotInstall.tr()),
      ),
    );
  }
}

navigateToMail({required BuildContext context, required String mail}) async {
  Uri url = Uri(scheme: 'mailto', path: '$mail');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(LocaleKeys.error.tr()),
      ),
    );
  }
}

Future<void> launchUrlSocial(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
