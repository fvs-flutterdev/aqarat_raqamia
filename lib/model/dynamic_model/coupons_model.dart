class CouponsModel {
  String? status;
  List<Data>? data;

  CouponsModel({this.status, this.data});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? code;
  String? discount;
  String? discountType;
  String? expiryDate;
  int? usageLimit;
  int? timesUsed;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.code,
        this.discount,
        this.discountType,
        this.expiryDate,
        this.usageLimit,
        this.timesUsed,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discount = json['discount'];
    discountType = json['discount_type'];
    expiryDate = json['expiry_date'];
    usageLimit = json['usage_limit'];
    timesUsed = json['times_used'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['expiry_date'] = this.expiryDate;
    data['usage_limit'] = this.usageLimit;
    data['times_used'] = this.timesUsed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}