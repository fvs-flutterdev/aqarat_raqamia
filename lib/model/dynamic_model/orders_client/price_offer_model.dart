class PriceOfferModel {
  List<Data>? data;
  Links? links;
  Meta? meta;

  PriceOfferModel({this.data, this.links, this.meta});

  PriceOfferModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? priceOfferId;
  Provider? provider;
  int? providerRate;
  int? price;
  int? commission;
  String? serviceDetails;
  BidDuration? bidDuration;
  String? status;

  Data(
      {this.priceOfferId,
      this.provider,
      this.providerRate,
      this.price,
      this.commission,
      this.serviceDetails,
      this.bidDuration,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    priceOfferId = json['price_offer_id'];
    providerRate = json['Provider_rate'];
    price = json['price'];
    commission = json['commission'];
    serviceDetails = json['service_details'];
    bidDuration = json['bid_duration'] != null
        ? new BidDuration.fromJson(json['bid_duration'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['price_offer_id'] = this.priceOfferId;
    data['Provider_rate'] = this.providerRate;
    data['price'] = this.price;
    data['commission'] = this.commission;
    data['service_details'] = this.serviceDetails;
    if (this.bidDuration != null) {
      data['bid_duration'] = this.bidDuration!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Provider {
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
  List<ProviderServices>? services;
  List<ProviderSubServices>? subServices;

  Provider(
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
      this.services,
      this.subServices});

  Provider.fromJson(Map<String, dynamic> json) {
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
      services = <ProviderServices>[];
      json['services'].forEach((v) {
        services!.add(new ProviderServices.fromJson(v));
      });
    }
    if (json['sub_services'] != null) {
      subServices = <ProviderSubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(new ProviderSubServices.fromJson(v));
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
    if (this.subServices != null) {
      data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProviderServices {
  int? id;
  String? name;
  bool? istabbed;

  ProviderServices({this.id, this.name, this.istabbed});

  ProviderServices.fromJson(Map<String, dynamic> json) {
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

class ProviderSubServices {
  int? id;
  String? name;
  bool? istabbed;

  ProviderSubServices({this.id, this.name, this.istabbed});

  ProviderSubServices.fromJson(Map<String, dynamic> json) {
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

class BidDuration {
  String? bidDurationHuman;
  String? bidDuration;
  String? remainingTime;

  BidDuration({this.bidDurationHuman, this.bidDuration, this.remainingTime});

  BidDuration.fromJson(Map<String, dynamic> json) {
    bidDurationHuman = json['bid_duration_human'];
    bidDuration = json['bid_duration'];
    remainingTime = json['remaining_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bid_duration_human'] = this.bidDurationHuman;
    data['bid_duration'] = this.bidDuration;
    data['remaining_time'] = this.remainingTime;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class PriceOfferLinks {
  String? url;
  String? label;
  bool? active;

  PriceOfferLinks({this.url, this.label, this.active});

  PriceOfferLinks.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
