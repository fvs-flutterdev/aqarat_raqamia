import 'package:aqarat_raqamia/bloc/map_ads_cubit/state.dart';
import 'package:aqarat_raqamia/utils/app_constant.dart';
import 'package:aqarat_raqamia/utils/base_url.dart';
import 'package:aqarat_raqamia/utils/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../model/dynamic_model/nearby_aqa_model.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/images.dart';
import '../../view/base/show_toast.dart';
import '../../view/screens/location/custom_marker_model.dart';

class AdsOnMapCubit extends Cubit<AdsOnMapState> {
  AdsOnMapCubit() : super(InitialMapAdsState());

  List<Marker> adsMarkers = [];
  late NearbyAqarModel nearbyAqarModel;
  int adsId = 0;
  int tabbed = 00;
  bool? isGetAqarData;

  int pagePaginate = 1;

  getAllAdsOnMap(
      {required BuildContext context,
      String? search,
 // GoogleMapController? controller,
      String? categoryId,
      String? adsType,
      String? space,
      String? maxPrice,
      String? minPrice,
        String? searchCity,
        String? searchDistrict,
      int? page}) {
  //  tabbed = 00;
    adsId = 0;
    isGetAqarData = false;
    DioHelper.getData(
      url: BaseUrl.baseUrl + BaseUrl.SearchAds,
      token: token,
      search: search ?? '',
      space: space ?? '',
      typeId: adsType ?? '',
      maxPrice: maxPrice ?? '',
      minPrice: minPrice ?? '',
      categoryId: categoryId ?? '',
      page: page,
      city: searchCity,
      district: searchDistrict,
      //  lat: context.read<LocationCubit>().position?.latitude.toString(),
      // lng: context.read<LocationCubit>().position?.longitude.toString(),
    ).then((value) async{
      if (page == 1) {
       // tabbed = 00;
        adsId = 0;
        nearbyAqarModel = await NearbyAqarModel.fromJson(value.data);
      //  isGetAqarData = true;
      } else {
        nearbyAqarModel.meta?.currentPage =
        await  NearbyAqarModel.fromJson(value.data).meta?.currentPage;
        nearbyAqarModel.meta?.lastPage =
        await  NearbyAqarModel.fromJson(value.data).meta?.lastPage;
        nearbyAqarModel.meta?.total =
        await  NearbyAqarModel.fromJson(value.data).meta?.total;
        nearbyAqarModel.meta?.perPage =
        await  NearbyAqarModel.fromJson(value.data).meta?.perPage;
        nearbyAqarModel.links?.next =
        await  NearbyAqarModel.fromJson(value.data).links?.next;
        nearbyAqarModel.links?.first =
        await  NearbyAqarModel.fromJson(value.data).links?.first;
        nearbyAqarModel.links?.last =
        await   NearbyAqarModel.fromJson(value.data).links?.last;
        nearbyAqarModel.links?.prev =
        await   NearbyAqarModel.fromJson(value.data).links?.prev;
        nearbyAqarModel.data
            ?.addAll(await NearbyAqarModel.fromJson(value.data).data!);
      //  isGetAqarData = true;

        // addMarkerAds();
      }
      await addMarkerAds();
      isGetAqarData = true;

      debugPrint('${nearbyAqarModel.data!.length.toString()}////////////////////////////^^');
      emit(GetAllAdsMapSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllAdsMapErrorState(error: error.toString()));
    });
  }

  addMarkerAds() async {
    adsMarkers.clear();
  //  tabbed = 00;
    adsId = 0;
    emit(FullMarkListAdsState());
    for (var data in nearbyAqarModel.data!) {
      // final marker=MarkersWithLabel.getBytesFromCanvasDynamic(
      //     iconPath: '',
      //     plateReg: '',
      //     fontSize: null,
      //     iconSize: null
      //
      // );
      final marker = Marker(
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(), Images.MARKER),
          infoWindow: InfoWindow(title: data.price),
          markerId:await MarkerId(data.id.toString()),
          position:await LatLng(double.parse(data.lat ?? '21.5574601'),
              double.parse(data.lan ?? '39.1775424')),
          onTap: () {
            changeTapMarker(id: data.id!);
          });
     // controller?.showMarkerInfoWindow(MarkerId(data.id.toString()));
      adsMarkers.add(marker);
      print(
          '/////////////////////////${adsMarkers.length}///////////////////////');
    }
    emit(FullMarkListAdsState());
  }

  changeTapMarker({
    required int id,
  })
  {
    adsId = nearbyAqarModel.data!.indexWhere((element) => element.id == id);
    print('indexx $adsId');
    tabbed = id;
    print('tabbed $tabbed');
    emit(ChangeTabbedMarkerState());
  }

  removeFavourite(int index, String adId, BuildContext context) {
    nearbyAqarModel.data![index].isFavorite =
        !nearbyAqarModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
      url: '${BaseUrl.baseUrl + BaseUrl.RemoveFavourite}/$adId',
      token: token,
    ).then((value) {
      print(value.data);
      // isFavourite=false;
      nearbyAqarModel.data![index].isFavorite = false;
      emit(RemoveAqarInMapFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.removeFavourite.tr(),
        state: ToastState.SUCCESS,
      );
    }).catchError((error) {
      print(error.toString());
      emit(RemoveAqarInMapFavouriteErrorState(error: error.toString()));
    });
  }

  addFavourite(int index, String adId, BuildContext context) {
    //isFavorite= ! isFavorite!;
    nearbyAqarModel.data![index].isFavorite =
        !nearbyAqarModel.data![index].isFavorite!;
    emit(ChangeFavouriteState());
    DioHelper.postData(
        url: BaseUrl.baseUrl + BaseUrl.AddFavourite,
        token: token,
        data: {
          "ads_id": adId,
        }).then((value) {
      print(value.data);
      nearbyAqarModel.data![index].isFavorite = true;
      emit(AddAqarInMapFavouriteSuccessState());
      showCustomSnackBar(
        message: LocaleKeys.addFavourite.tr(),
        state: ToastState.SUCCESS,
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddAqarInMapFavouriteErrorState(error: error.toString()));
    });
  }

  int selectedIndex = 0;

  changeIndexCarousel(index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }


}
