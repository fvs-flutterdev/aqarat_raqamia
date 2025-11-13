import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../../bloc/location_cubit/cubit.dart';
import '../../../bloc/profile_cubit/cubit.dart';
import '../../../bloc/start_app_cubit/cubit.dart';
import '../../../bloc/start_app_cubit/state.dart';
import '../../../main.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/images.dart';
import '../../../utils/shared_pref.dart';
import '../../../view/base/lunch_widget.dart';
import '../../../view/screens/boarding/boarding_screen.dart';
import '../../../view/screens/bottom_navigation/main_screen.dart';
import '../../../view/screens/network_error_screen/network_error.dart';
import '../biometrics_auth/verify_bio_auth_code.dart';
import '../subscribtion_screen/packages_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    // navigateForwardReplace(MainScreenNavigation()); //TODO: remove this
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation =
        CurvedAnimation(parent: _controller!, curve: Curves.elasticOut);
    _controller!.repeat(reverse: true);
    context.read<LocationCubit>().getAllRegions();
    context.read<LocationCubit>().getCurrentPosition();
    if (token != null) {
      context.read<ProfileCubit>().getProfileData();
      auth.isDeviceSupported().then(
            (bool isSupported) => setState(() => _supportState = isSupported
                ? _SupportState.supported
                : _SupportState.unsupported),
          );
    }
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print('/////////////////////////////////${e.details}');
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
      print('/////////////////$message');
    });
    if (message == "Authorized") {
      navigateForwardReplace(MainScreenNavigation());
    } else {
      navigateForward(VerifyBioNumber());
      //  _controller!.repeat();
      //  navigateForward(VerificationScreen(phone: context.read<ProfileCubit>().profileModel.userProfile?.phone??'',));
    }
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return BlocConsumer<StartAppCubit, StartAppState>(
      listener: (context, state) {
        if (state is GetBoardingDataLoadingState ||
            state is InitialStartAppState ||
            state is GetAccountTypeDataLoadingState) {
          _controller!.repeat(reverse: true);
        } else if (state is GetBoardingDataSuccessState ||
            state is GetAccountTypeDataSuccessState) {
          Timer(const Duration(seconds: 2), () async {
            if (CacheHelper.getData(key: 'token') == null) {
              navigateForwardReplace(BoardingScreen());
            } else if (
                //    CacheHelper.getData(key: 'isSubscribed')
                isProviderSubscribed == false &&
                    CacheHelper.getData(key: 'status') == 'service_provider') {
              navigateForwardReplace(PackagesScreen());
            } else {
              isBioActiveForUser == true
                  ? _authenticateWithBiometrics()
                  : navigateForwardReplace(MainScreenNavigation());
              //  _authenticateWithBiometrics();
              //  navigateForwardReplace(MainScreenNavigation());
              //  navigateForwardReplace(BiometricsAuth());
            }
            // navigateForwardReplace(CacheHelper.getData(key: 'token') == null
            //     ?
            // BoardingScreen()
            //     : CacheHelper.getData(key: 'isSubscribed') == false &&
            //             CacheHelper.getData(key: 'status') == 'service_provider'
            //         ? PackagesScreen()
            //         : MainScreenNavigation());
          });
        } else if (state is GetAccountTypeDataErrorState ||
            state is GetBoardingDataErrorState) {
          navigateForward(NetWorkErrorScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _globalKey,
          body: Stack(
            children: [
              Image.asset(
                Images.SPLASH_BACKGROUND,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Center(
                child: ScaleTransition(
                  scale: _animation!,
                  child: Image.asset(Images.LOGO_SPLASH),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
