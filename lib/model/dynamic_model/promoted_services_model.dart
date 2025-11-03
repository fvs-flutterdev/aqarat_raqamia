class PromotionServicesModel {
  String? message;
  List<Data>? data;

  PromotionServicesModel({this.message, this.data});

  PromotionServicesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  User? user;
  Service? service;

  Data({this.user, this.service});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? photo;
  String? countryCode;
  String? phone;
  Null? whatsappNumber;
  Null? email;
  Null? emailVerifiedAt;
  String? type;
  String? status;
  String? statusUser;
  String? location;
  String? country;
  Null? rate;
  Null? notes;
  Null? value;
  String? experienceYears;
  Null? visionary;
  Null? objectives;
  Null? typeLicense;
  int? licenseId;
  String? district;
  String? lan;
  String? lat;
  Null? fcmToken;
  Null? balance;
  String? createdAt;
  String? updatedAt;
  String? promoted;
  Null? promotionBidDuration;

  User(
      {this.id,
        this.name,
        this.photo,
        this.countryCode,
        this.phone,
        this.whatsappNumber,
        this.email,
        this.emailVerifiedAt,
        this.type,
        this.status,
        this.statusUser,
        this.location,
        this.country,
        this.rate,
        this.notes,
        this.value,
        this.experienceYears,
        this.visionary,
        this.objectives,
        this.typeLicense,
        this.licenseId,
        this.district,
        this.lan,
        this.lat,
        this.fcmToken,
        this.balance,
        this.createdAt,
        this.updatedAt,
        this.promoted,
        this.promotionBidDuration});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    countryCode = json['country_code'];
    phone = json['phone'];
    whatsappNumber = json['whatsapp_number'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    status = json['status'];
    statusUser = json['status_user'];
    location = json['location'];
    country = json['country'];
    rate = json['rate'];
    notes = json['notes'];
    value = json['value'];
    experienceYears = json['experience_years'];
    visionary = json['visionary'];
    objectives = json['objectives'];
    typeLicense = json['type_license'];
    licenseId = json['license_id'];
    district = json['district'];
    lan = json['lan'];
    lat = json['lat'];
    fcmToken = json['fcm_token'];
    balance = json['balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promoted = json['promoted'];
    promotionBidDuration = json['promotion_bid_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['whatsapp_number'] = this.whatsappNumber;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['type'] = this.type;
    data['status'] = this.status;
    data['status_user'] = this.statusUser;
    data['location'] = this.location;
    data['country'] = this.country;
    data['rate'] = this.rate;
    data['notes'] = this.notes;
    data['value'] = this.value;
    data['experience_years'] = this.experienceYears;
    data['visionary'] = this.visionary;
    data['objectives'] = this.objectives;
    data['type_license'] = this.typeLicense;
    data['license_id'] = this.licenseId;
    data['district'] = this.district;
    data['lan'] = this.lan;
    data['lat'] = this.lat;
    data['fcm_token'] = this.fcmToken;
    data['balance'] = this.balance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['promoted'] = this.promoted;
    data['promotion_bid_duration'] = this.promotionBidDuration;
    return data;
  }
}

class Service {
  int? id;
  String? name;
  String? nameEn;
  String? photo;
  String? notes;
  String? notesEn;
  String? createdAt;
  String? updatedAt;

  Service(
      {this.id,
        this.name,
        this.nameEn,
        this.photo,
        this.notes,
        this.notesEn,
        this.createdAt,
        this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    photo = json['photo'];
    notes = json['notes'];
    notesEn = json['notes_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['photo'] = this.photo;
    data['notes'] = this.notes;
    data['notes_en'] = this.notesEn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}