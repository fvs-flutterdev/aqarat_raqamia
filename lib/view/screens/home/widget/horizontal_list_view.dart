import 'package:aqarat_raqamia/utils/media_query_value.dart';
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:aqarat_raqamia/view/base/lunch_widget.dart';
import 'package:aqarat_raqamia/view/base/shimmer/ads_shimmer.dart';
import 'package:aqarat_raqamia/view/error_widget/error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/ads_by_id_cubit/cubit.dart';
import '../../../../bloc/nearby_aqar_cubit/cubit.dart';
import '../../../../bloc/nearby_aqar_cubit/state.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../utils/dimention.dart';
import '../../../../utils/images.dart';
import '../../../base/pagination_view.dart';
import '../../../restart_widget/restart_widget.dart';
import '../../details_screen/aqar_details_screen.dart';
import '../../favourites/widget/favourite_widget.dart';

class HorizontalNearbyListView extends StatefulWidget {
  double? height;
  double? width;
  bool? isCategory;

  HorizontalNearbyListView(
      {super.key, this.height, this.width, this.isCategory});

  @override
  State<HorizontalNearbyListView> createState() =>
      _HorizontalNearbyListViewState();
}

class _HorizontalNearbyListViewState extends State<HorizontalNearbyListView> {
  TextEditingController searchController = TextEditingController();

  final _scrollController = ScrollController();

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var getNearbyData = context.read<NearbyAqarCubit>();
    return BlocBuilder<NearbyAqarCubit, NearbyAqarState>(
      builder: (context, state) {
        if (getNearbyData.isNearbyAqar == false) {
          return AdsShimmer(
            isCategory: widget.isCategory ?? true,
          );
        } else if (getNearbyData.nearbyAqarModel.data!.isEmpty) {
          return Center(
              child: Text(
            LocaleKeys.noData.tr(),
            style: openSansMedium.copyWith(color: darkGreyColor),
          ));
        } else if (state is GetNearbyAqarErrorState) {
          return CustomErrorWidget(reload: () {
            return getNearbyData.getNearbyAqarData(context: context, page: 1);
          });
        } else {
          return Container(
            padding: EdgeInsets.zero,
            height: getNearbyData.nearbyAqarModel.data!.length >= 2
                ? widget.height ?? context.height * 0.69.sp
                : widget.height ?? context.height * 0.3.sp,
            child: SingleChildScrollView(
              controller: _scrollController,


              child: PaginatedListView(
                offset: getNearbyData.nearbyAqarModel.meta!.currentPage!,
                last: getNearbyData.nearbyAqarModel.meta!.lastPage!,
                onPaginate: (int offset) async {
                  print('/////////////////////////////////////////////');
                  print(offset);
                  await getNearbyData.getNearbyAqarData(
                    search: searchController.text,
                    context: context,
                    page: offset,
                  );
                },
                scrollController: _scrollController,
                totalSize: getNearbyData.nearbyAqarModel.meta?.to ?? 15,

                //reverse: true,
                enabledPagination: true,
                productView: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: Dimensions.PADDING_SIZE_DEFAULT,
                      );
                    },
                    //  scrollDirection: Axis.horizontal,
                    itemCount: getNearbyData.nearbyAqarModel.data!.length,
                    itemBuilder: (context, index) {
                      return FavouriteWidget(
                        categoryId: getNearbyData
                            .nearbyAqarModel.data![index].categoryAds?.id,
                        features: getNearbyData
                            .nearbyAqarModel.data![index].additionalFeatures,

                        isTabbedFavourite: getNearbyData
                            .nearbyAqarModel.data![index].isFavorite!,
                        favouriteFunction: () {
                          getNearbyData.nearbyAqarModel.data![index].isFavorite!
                              ? getNearbyData.removeFavourite(
                                  index,
                                  getNearbyData.nearbyAqarModel.data![index].id
                                      .toString(),
                                  context,
                                )
                              : getNearbyData.addFavourite(
                                  index,
                                  getNearbyData.nearbyAqarModel.data![index].id
                                      .toString(),
                                  context,
                                );
                        },
                        // favouriteFunction: () {
                        //   filterSearchCubit.searchResultModel.data!.first.isFavourite! ? filterSearchCubit.removeFavourite(0, filterSearchCubit.searchResultModel.data!.first.id.toString())
                        //       : filterSearchCubit.addFavourite(
                        //       0,
                        //       filterSearchCubit
                        //           .searchResultModel.data!.first.id
                        //           .toString());
                        // },
                        onTap: () {
                          //RestartWidget.restartApp(context);
                          context.read<AdyByIdCubit>().getAdById(
                              id: getNearbyData
                                  .nearbyAqarModel.data![index].id!);
                          navigateForward(AqarDetailsScreen(
                            adId:
                                getNearbyData.nearbyAqarModel.data![index].id!,
                            categoryId: getNearbyData
                                .nearbyAqarModel.data![index].categoryAds!.id
                                .toString(),
                          ));
                        },
                        width: widget.width ?? context.width * 0.8.sp,
                        adLocation:
                            '${getNearbyData.nearbyAqarModel.data![index].district}, ${getNearbyData.nearbyAqarModel.data![index].city}, ${getNearbyData.nearbyAqarModel.data![index].region}',
                        // adLocation:
                        //     getNearbyData.nearbyAqarModel.data![index].address ??
                        //         '',
                        title: getNearbyData.nearbyAqarModel.data![index].name ??
                            '',
                        image: getNearbyData.nearbyAqarModel.data![index].photos?.first??
                            Images.AVATAR_IMAGE,
                        bathNo: getNearbyData
                                .nearbyAqarModel.data![index].toiletsNumber ??
                            '',
                        bedNo: getNearbyData
                                .nearbyAqarModel.data![index].roomsNumber ??
                            '',
                        price:
                            '${getNearbyData.nearbyAqarModel.data![index].price}',
                        //  kitchenNo: '2', livingNo: '2'
                      );
                    }),
              ),
            ),
          );
        }
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class OtpScreen extends StatelessWidget {
//   const OtpScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "OTP Verification",
//           style: TextStyle(color: Color(0xFF757575)),
//         ),
//       ),
//       body: SafeArea(
//         child: SizedBox(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   const Text(
//                     "OTP Verification",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "We sent your code to +1 898 860 *** \nThis code will expired in 00:30",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Color(0xFF757575)),
//                   ),
//                   // const SizedBox(height: 16),
//                   SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//                   const OtpForm(),
//                   SizedBox(height: MediaQuery.of(context).size.height * 0.2),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       "Resend OTP Code",
//                       style: TextStyle(color: Color(0xFF757575)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// const authOutlineInputBorder = OutlineInputBorder(
//   borderSide: BorderSide(color: Color(0xFF757575)),
//   borderRadius: BorderRadius.all(Radius.circular(12)),
// );
//
// class OtpForm extends StatelessWidget {
//   const OtpForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SizedBox(
//                 height: 64,
//                 width: 64,
//                 child: TextFormField(
//                   onSaved: (pin) {},
//                   onChanged: (pin) {
//                     if (pin.isNotEmpty) {
//                       FocusScope.of(context).nextFocus();
//                     }
//                   },
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(1),
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   style: Theme.of(context).textTheme.titleLarge,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                       hintText: "0",
//                       hintStyle: const TextStyle(color: Color(0xFF757575)),
//                       border: authOutlineInputBorder,
//                       enabledBorder: authOutlineInputBorder,
//                       focusedBorder: authOutlineInputBorder.copyWith(
//                           borderSide:
//                           const BorderSide(color: Color(0xFFFF7643)))),
//                 ),
//               ),
//               SizedBox(
//                 height: 64,
//                 width: 64,
//                 child: TextFormField(
//                   onSaved: (pin) {},
//                   onChanged: (pin) {
//                     if (pin.isNotEmpty) {
//                       FocusScope.of(context).nextFocus();
//                     }
//                   },
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(1),
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   style: Theme.of(context).textTheme.titleLarge,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                       hintText: "0",
//                       hintStyle: const TextStyle(color: Color(0xFF757575)),
//                       border: authOutlineInputBorder,
//                       enabledBorder: authOutlineInputBorder,
//                       focusedBorder: authOutlineInputBorder.copyWith(
//                           borderSide:
//                           const BorderSide(color: Color(0xFFFF7643)))),
//                 ),
//               ),
//               SizedBox(
//                 height: 64,
//                 width: 64,
//                 child: TextFormField(
//                   onSaved: (pin) {},
//                   onChanged: (pin) {
//                     if (pin.isNotEmpty) {
//                       FocusScope.of(context).nextFocus();
//                     }
//                   },
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(1),
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   style: Theme.of(context).textTheme.titleLarge,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                       hintText: "0",
//                       hintStyle: const TextStyle(color: Color(0xFF757575)),
//                       border: authOutlineInputBorder,
//                       enabledBorder: authOutlineInputBorder,
//                       focusedBorder: authOutlineInputBorder.copyWith(
//                           borderSide:
//                           const BorderSide(color: Color(0xFFFF7643)))),
//                 ),
//               ),
//               SizedBox(
//                 height: 64,
//                 width: 64,
//                 child: TextFormField(
//                   onSaved: (pin) {},
//                   onChanged: (pin) {
//                     if (pin.isNotEmpty) {
//                       FocusScope.of(context).nextFocus();
//                     }
//                   },
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(1),
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   style: Theme.of(context).textTheme.titleLarge,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                       hintText: "0",
//                       hintStyle: const TextStyle(color: Color(0xFF757575)),
//                       border: authOutlineInputBorder,
//                       enabledBorder: authOutlineInputBorder,
//                       focusedBorder: authOutlineInputBorder.copyWith(
//                           borderSide:
//                           const BorderSide(color: Color(0xFFFF7643)))),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               elevation: 0,
//               backgroundColor: const Color(0xFFFF7643),
//               foregroundColor: Colors.white,
//               minimumSize: const Size(double.infinity, 48),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(16)),
//               ),
//             ),
//             child: const Text("Continue"),
//           )
//         ],
//       ),
//     );
//   }
// }
