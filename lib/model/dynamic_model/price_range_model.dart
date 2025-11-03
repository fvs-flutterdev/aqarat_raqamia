class PriceRangeModel {
  String? status;
  Data? data;

  PriceRangeModel({this.status, this.data});

  PriceRangeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? minPrice;
  int? maxPrice;

  Data({this.minPrice, this.maxPrice});

  Data.fromJson(Map<String, dynamic> json) {
    minPrice = int.tryParse(json['min_price']);
    maxPrice = int.tryParse(json['max_price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    return data;
  }
}