import 'package:aqarat_raqamia/utils/app_constant.dart';

import '../../utils/base_url.dart';
import '../../utils/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../model/dynamic_model/sponsor_partner_model.dart';
import 'state.dart';

class PartnerSponsorCubit extends Cubit<PartnerSponsorState> {
  PartnerSponsorCubit() : super(InitialPartnerSponsorState());
  late PartnerSponsorModel partnerSponsorModel;
  late VideoPlayerController videoPlayerController;

  getPartnerSponsor() {
    emit(GetPartnerSponsorLoadingState());
    DioHelper.getData(
      url: BaseUrl.baseUrl + BaseUrl.GetPartnerSponsor,
      regionId: currentRegion

    ).then((value) {
      partnerSponsorModel = PartnerSponsorModel.fromJson(value.data);
      print(value.data);

      emit(GetPartnerSponsorSuccessState());
      if (partnerSponsorModel.data!.backgroundImage!.endsWith(".mp4")) {
    // playVideo();

      //
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
           partnerSponsorModel.data?.backgroundImage??''
         // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      ))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          emit(PlayVideoSponsorSuccessState());
          videoPlayerController.play();
          videoPlayerController.setLooping(true);


        });
       }
    }).catchError((error) {
      print(error.toString());
      emit(GetPartnerSponsorErrorState(error: error.toString()));
    });
  }

  // @override
  // Future<void> close() async {
  //   await videoPlayerController.dispose();
  //   super.close();
  // }

  playVideo() {
    // if (partnerSponsorModel.data!.backgroundImage!.endsWith(".mp4")) {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        //   partnerSponsorModel.data?.backgroundImage??
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        emit(PlayVideoSponsorSuccessState());
        videoPlayerController.play();
        // videoPlayerController.setVolume(0.0);
        videoPlayerController.setLooping(true);
      });
    //  }
  }
}
