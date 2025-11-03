class PaymentPriceServiceModel {
  PaymentDetails? paymentDetails;

  PaymentPriceServiceModel({this.paymentDetails});

  PaymentPriceServiceModel.fromJson(Map<String, dynamic> json) {
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
  int? price;
  String? transaction;
  String? orderNumber;
  String? payDate;

  Data({this.price, this.transaction, this.orderNumber,this.payDate});

  Data.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    payDate=json['pay_date'];
    transaction = json['transaction'];
    orderNumber = json['order_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['pay_date']=this.payDate;
    data['transaction'] = this.transaction;
    data['order_number'] = this.orderNumber;
    return data;
  }
}