class ServiceProviderPromoted {
  List<Data>? data;

  ServiceProviderPromoted({this.data});

  ServiceProviderPromoted.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  UserAds? userAds;
  List<Services>? services;
  List<SubServicesPromo>? subServicesPromo;
  bool? promoted;

  Data(
      {this.id,
        this.userAds,
         this.subServicesPromo,
        this.services,
        this.promoted,});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userAds = json['user_ads'] != null
        ? new UserAds.fromJson(json['user_ads'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['sub_services'] != null) {
      subServicesPromo = <SubServicesPromo>[];
      json['sub_services'].forEach((v) {
        subServicesPromo!.add(new SubServicesPromo.fromJson(v));
      });
    }
    promoted = json['promoted'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userAds != null) {
      data['user_ads'] = this.userAds!.toJson();
    }


    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.subServicesPromo != null) {
      data['sub_services'] = this.subServicesPromo!.map((v) => v.toJson()).toList();
    }
    data['promoted'] = this.promoted;
    return data;
  }
}

class UserAds {
  int? id;
  String? name;
  String? phone;
  String? countryCode;
  String? photo;
  String? email;
  String? type;
  String? status;
  String? statusUser;
  bool? isSubscribed;
  String? location;
  String? country;
  double? rate;
  int? noRate;
  String? notes;
  String? value;
  String? visionary;
  String? objectives;
  License? license;
  String? district;
  String? lan;
  String? lat;
  String? fcmToken;
  String? experienceYears;
  String? whatsappNumber;
  List<String>? projects;
  List<String>? achievements;
  List<String>? imagesAlbum;
  List<Services>? services;

  UserAds(
      {this.id,
        this.name,
        this.phone,
        this.countryCode,
        this.photo,
        this.email,
        this.type,
        this.status,
        this.statusUser,
        this.isSubscribed,
        this.location,
        this.country,
        this.rate,
        this.noRate,
        this.notes,
        this.value,
        this.visionary,
        this.objectives,
        this.license,
        this.district,
        this.lan,
        this.lat,
        this.fcmToken,
        this.experienceYears,
        this.whatsappNumber,
        this.projects,
        this.achievements,
        this.imagesAlbum,
        this.services,});

  UserAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    countryCode = json['country_code'];
    photo = json['photo'];
    email = json['email'];
    type = json['type'];
    status = json['status'];
    statusUser = json['status_user'];
    isSubscribed = json['is_subscribed'];
    location = json['location'];
    country = json['country'];
    rate = json['rate'];
    noRate = json['noRate'];
    notes = json['notes'];
    value = json['value'];
    visionary = json['visionary'];
    objectives = json['objectives'];
    license =
    json['license'] != null ? new License.fromJson(json['license']) : null;
    district = json['district'];
    lan = json['lan'];
    lat = json['lat'];
    fcmToken = json['fcm_token'];
    experienceYears = json['experience_years'];
    whatsappNumber = json['whatsapp_number'];
    projects = json['projects'].cast<String>();
    achievements = json['achievements'].cast<String>();
    imagesAlbum = json['images_album'].cast<String>();
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['type'] = this.type;
    data['status'] = this.status;
    data['status_user'] = this.statusUser;
    data['is_subscribed'] = this.isSubscribed;
    data['location'] = this.location;
    data['country'] = this.country;
    data['rate'] = this.rate;
    data['noRate'] = this.noRate;
    data['notes'] = this.notes;
    data['value'] = this.value;
    data['visionary'] = this.visionary;
    data['objectives'] = this.objectives;
    if (this.license != null) {
      data['license'] = this.license!.toJson();
    }
    data['district'] = this.district;
    data['lan'] = this.lan;
    data['lat'] = this.lat;
    data['fcm_token'] = this.fcmToken;
    data['experience_years'] = this.experienceYears;
    data['whatsapp_number'] = this.whatsappNumber;
    data['projects'] = this.projects;
    data['achievements'] = this.achievements;
    data['images_album'] = this.imagesAlbum;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class License {
  int? id;
  String? name;
  bool? istabbed;

  License({this.id, this.name, this.istabbed});

  License.fromJson(Map<String, dynamic> json) {
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

class Services {
  int? id;
  String? name;

  Services({this.id, this.name});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SubServicesPromo {
  int? id;
  String? name;
  int? servicesId;

  SubServicesPromo({this.id, this.name,this.servicesId});

  SubServicesPromo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    servicesId=json['services_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data["services_id"]=this.servicesId;
    return data;
  }
}