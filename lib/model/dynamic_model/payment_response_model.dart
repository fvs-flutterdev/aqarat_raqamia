class PaymentResponseModel {
  PaymentDetails? paymentDetails;

  PaymentResponseModel({this.paymentDetails});

  PaymentResponseModel.fromJson(Map<String, dynamic> json) {
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
  Data? data;

  PaymentDetails({this.message, this.data});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
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
  String? bidDuration;
  String? price;
  String? transaction;
  String? orderNumber;
  String? type;
  bool? isSubscribed;

  Data(
      {this.bidDuration,
        this.price,
        this.transaction,
        this.orderNumber,
        this.isSubscribed,
        this.type});

  Data.fromJson(Map<String, dynamic> json) {
    bidDuration = json['bid_duration'];
    price = json['price'];
    transaction = json['transaction'];
    orderNumber = json['order_number'];
    isSubscribed=json['is_subscribed'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bid_duration'] = this.bidDuration;
    data['price'] = this.price;
    data['transaction'] = this.transaction;
    data['order_number'] = this.orderNumber;
    data['is_subscribed']= this.isSubscribed;
    data['type'] = this.type;
    return data;
  }
}