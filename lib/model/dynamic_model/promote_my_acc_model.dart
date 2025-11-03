class PromotedServiceProviderModel {
  PaymentDetails? paymentDetails;

  PromotedServiceProviderModel({this.paymentDetails});

  PromotedServiceProviderModel.fromJson(Map<String, dynamic> json) {
    paymentDetails = json['paymentDetails'] != null
        ? new PaymentDetails.fromJson(json['paymentDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentDetails != null) {
      data['paymentDetails'] = this.paymentDetails!.toJson();
    }
    return data;
  }
}

class PaymentDetails {
  String? message;
  String? messageEn;
  Data? data;

  PaymentDetails({this.message, this.messageEn, this.data});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageEn = json['message_en'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['message_en'] = this.messageEn;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? promotionBidDuration;
  String? price;
  String? transaction;
  String? orderNumber;

  Data(
      {this.promotionBidDuration,
        this.price,
        this.transaction,
        this.orderNumber});

  Data.fromJson(Map<String, dynamic> json) {
    promotionBidDuration = json['promotion_bid_duration'];
    price = json['price'];
    transaction = json['transaction'];
    orderNumber = json['order_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promotion_bid_duration'] = this.promotionBidDuration;
    data['price'] = this.price;
    data['transaction'] = this.transaction;
    data['order_number'] = this.orderNumber;
    return data;
  }
}