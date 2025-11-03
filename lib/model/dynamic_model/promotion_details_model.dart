class PromotionDetailsModel {
  String? message;
  Data? data;

  PromotionDetailsModel({this.message, this.data});

  PromotionDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? promotionValueService;
  int? promotionDaysService;

  Data({this.promotionValueService, this.promotionDaysService});

  Data.fromJson(Map<String, dynamic> json) {
    promotionValueService = json['promotion_value_service'];
    promotionDaysService = json['promotion_days_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promotion_value_service'] = this.promotionValueService;
    data['promotion_days_service'] = this.promotionDaysService;
    return data;
  }
}