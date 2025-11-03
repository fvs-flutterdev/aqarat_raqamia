
import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/responsive_helper.dart';
import '../../translation/locale_keys.g.dart';
import '../../utils/dimention.dart';

class PaginatedListViewTry extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int offset) onPaginate;
  final int totalSize;
   int offset;
  final Widget productView;
  final bool enabledPagination;
  final bool reverse;
  final bool isChat;
   PaginatedListViewTry({ required this.scrollController, required this.onPaginate, required this.totalSize,
    this.isChat=true,
    required this.offset, required this.productView, this.enabledPagination = true, this.reverse = false,
  }) : super();

  @override
  State<PaginatedListViewTry> createState() => _PaginatedListViewTryState();
}

class _PaginatedListViewTryState extends State<PaginatedListViewTry> {
  int? _offset;
  List<int>? _offsetList;
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();

    // _offset = 1;
    // _offsetList = [1];

    // widget.scrollController.addListener(() {
    //   if (widget.scrollController.position.pixels == widget.scrollController.position.maxScrollExtent
    //       && widget.totalSize != null && !_isLoading && widget.enabledPagination) {
    //     if(mounted && !ResponsiveHelper.isDesktop(context)) {
    //       _paginate();
    //     }
    //   }
    // });
    if(widget.isChat==true){
      _offset = 1;
      _offsetList = [1];
      widget.scrollController.addListener(() {
        if (widget.scrollController.position.atEdge) {
          if (widget.scrollController.position.pixels != 0&&mounted && !ResponsiveHelper.isDesktop(context)) {
            // context.read<MyAdsCubit>().;
            _paginate();
          }
        }
      });
    }else{
      widget.scrollController.addListener(() {
        if ( widget.scrollController.position.atEdge) {
          if ( widget.scrollController.position.pixels != 0) {
            _paginate();
          }
        }
      });
    }

  }

  void _paginate() async {
   if(widget.totalSize >15){
    widget.offset +=1;
    print('...............................${widget.offset}');
    widget.onPaginate(widget.offset);
   }
  }

  @override
  Widget build(BuildContext context) {
    // if(widget.offset != null) {
    //   _offset = widget.offset;
    //   _offsetList = [];
    //   for(int index=1; index<=widget.offset; index++) {
    //     _offsetList?.add(index);
    //   }
    // }
    // if(widget.isChat==true){
    //   _offset = 1;
    //   _offsetList = [1];
    //   widget.scrollController.addListener(() {
    //     if (widget.scrollController.position.atEdge) {
    //       if (widget.scrollController.position.pixels != 0&&mounted && !ResponsiveHelper.isDesktop(context)) {
    //         // context.read<MyAdsCubit>().;
    //         _paginate();
    //       }
    //     }
    //   });
    // }else{
    //   widget.scrollController.addListener(() {
    //     if ( widget.scrollController.position.atEdge) {
    //       if ( widget.scrollController.position.pixels != 0) {
    //         _paginate();
    //       }
    //     }
    //   });
    // }
    _paginate();
    return Column(children: [

      widget.reverse ? SizedBox() : widget.productView,

      (ResponsiveHelper.isDesktop(context) && (widget.totalSize == null || _offset! >= (widget.totalSize / 10).ceil()
          || _offsetList!.contains(_offset!+1))) ? SizedBox() : Center(child: Padding(
        padding: (_isLoading || ResponsiveHelper.isDesktop(context)) ? EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL) : EdgeInsets.zero,
        child: _isLoading ? CircularProgressIndicator() : (ResponsiveHelper.isDesktop(context) && widget.totalSize != null) ? InkWell(
          onTap: _paginate,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_LARGE),
            margin: ResponsiveHelper.isDesktop(context) ? EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL) : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              color: Theme.of(context).primaryColor,
            ),
            child: Text(LocaleKeys.view_more.tr(), style: openSansMedium.copyWith(fontSize: 16.sp, color: Colors.white)),
          ),
        ) : SizedBox(),
      )),

      widget.reverse ? widget.productView : SizedBox(),

    ]);
  }
}
