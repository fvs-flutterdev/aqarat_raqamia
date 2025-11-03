class AdsPaymentsModel {
  PaymentDetails? paymentDetails;

  AdsPaymentsModel({this.paymentDetails});

  AdsPaymentsModel.fromJson(Map<String, dynamic> json) {
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

  PaymentDetails({this.message, this.data,this.messageEn});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageEn=json['message_en'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['message_en']=this.messageEn;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? bidDuration;
  int? price;
  String? transaction;
  String? orderNumber;
  AdDetails? adDetails;

  Data(
      {this.bidDuration,
        this.price,
        this.transaction,
        this.orderNumber,
        this.adDetails});

  Data.fromJson(Map<String, dynamic> json) {
    bidDuration = json['bid_duration'];
    price = json['price'];
    transaction = json['transaction'];
    orderNumber = json['order_number'];
    adDetails = json['ad_details'] != null
        ? new AdDetails.fromJson(json['ad_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bid_duration'] = this.bidDuration;
    data['price'] = this.price;
    data['transaction'] = this.transaction;
    data['order_number'] = this.orderNumber;
    if (this.adDetails != null) {
      data['ad_details'] = this.adDetails!.toJson();
    }
    return data;
  }
}

class AdDetails {
  int? id;
  UserAds? userAds;
  CategoryAds? categoryAds;
  String? space;
  String? roomsNumber;
  String? toiletsNumber;
  String? prolongation;
  Type? type;
  String? address;
  String? notes;
  String? price;
  String? status;
  String? lan;
  String? lat;
  List<String>? photos;
  bool? isFavorite;
  CreateDates? createDates;
  UpdateDates? updateDates;

  AdDetails(
      {this.id,
        this.userAds,
        this.categoryAds,
        this.space,
        this.roomsNumber,
        this.toiletsNumber,
        this.prolongation,
        this.type,
        this.address,
        this.notes,
        this.price,
        this.status,
        this.lan,
        this.lat,
        this.photos,
        this.isFavorite,
        this.createDates,
        this.updateDates});

  AdDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userAds = json['user_ads'] != null
        ? new UserAds.fromJson(json['user_ads'])
        : null;
    categoryAds = json['category_ads'] != null
        ? new CategoryAds.fromJson(json['category_ads'])
        : null;
    space = json['space'];
    roomsNumber = json['rooms_number'];
    toiletsNumber = json['toilets_number'];
    prolongation = json['prolongation'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    address = json['address'];
    notes = json['notes'];
    price = json['price'];
    status = json['status'];
    lan = json['lan'];
    lat = json['lat'];
    photos = json['photos'].cast<String>();
    isFavorite = json['is_favorite'];
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userAds != null) {
      data['user_ads'] = this.userAds!.toJson();
    }
    if (this.categoryAds != null) {
      data['category_ads'] = this.categoryAds!.toJson();
    }
    data['space'] = this.space;
    data['rooms_number'] = this.roomsNumber;
    data['toilets_number'] = this.toiletsNumber;
    data['prolongation'] = this.prolongation;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    data['address'] = this.address;
    data['notes'] = this.notes;
    data['price'] = this.price;
    data['status'] = this.status;
    data['lan'] = this.lan;
    data['lat'] = this.lat;
    data['photos'] = this.photos;
    data['is_favorite'] = this.isFavorite;
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}

class UserAds {
  int? id;
  String? name;
  String? photo;

  UserAds({this.id, this.name, this.photo});

  UserAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }
}

class CategoryAds {
  int? id;
  String? name;
  String? photo;
  bool? istabbed;

  CategoryAds({this.id, this.name, this.photo, this.istabbed});

  CategoryAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['istabbed'] = this.istabbed;
    return data;
  }
}

class Type {
  int? id;
  String? name;
  bool? istabbed;

  Type({this.id, this.name, this.istabbed});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['istabbed'] = this.istabbed;
    return data;
  }
}

class CreateDates {
  String? createdAtHuman;
  String? createdAt;

  CreateDates({this.createdAtHuman, this.createdAt});

  CreateDates.fromJson(Map<String, dynamic> json) {
    createdAtHuman = json['created_at_human'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at_human'] = this.createdAtHuman;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class UpdateDates {
  String? updatedAtHuman;
  String? updatedAt;

  UpdateDates({this.updatedAtHuman, this.updatedAt});

  UpdateDates.fromJson(Map<String, dynamic> json) {
    updatedAtHuman = json['updated_at_human'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at_human'] = this.updatedAtHuman;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}