class CarouselBannerModel {
  String? status;
  List<String>? data;

  CarouselBannerModel({this.status, this.data});

  CarouselBannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}