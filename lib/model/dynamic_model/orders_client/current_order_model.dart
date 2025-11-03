// class CurrentOrderClientModel {
//   List<Data>? data;
//   Links? links;
//   Meta? meta;
//
//   CurrentOrderClientModel({this.data, this.links, this.meta});
//
//   CurrentOrderClientModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     links = json['links'] != null ? new Links.fromJson(json['links']) : null;
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     if (this.links != null) {
//       data['links'] = this.links!.toJson();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   UserRequestServices? userRequestServices;
//   ServicesId? servicesId;
//   ServicesId? subServicesId;
//   String? country;
//   String? locations;
//   String? notes;
//   String? date;
//   String? code;
//   String? lat;
//   String? lan;
//   String? status;
//   List<String>? photos;
//   int? avgOffers;
//   bool? isAccepted;
//   AcceptedPriceOffers? acceptedPriceOffers;
//   CreateDates? createDates;
//   UpdateDates? updateDates;
//
//   Data(
//       {this.id,
//         this.userRequestServices,
//         this.servicesId,
//         this.subServicesId,
//         this.country,
//         this.locations,
//         this.notes,
//         this.date,
//         this.code,
//         this.lat,
//         this.lan,
//         this.status,
//         this.photos,
//         this.avgOffers,
//         this.isAccepted,
//         this.acceptedPriceOffers,
//         this.createDates,
//         this.updateDates});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userRequestServices = json['user_request_services'] != null
//         ? new UserRequestServices.fromJson(json['user_request_services'])
//         : null;
//     servicesId = json['services_id'] != null
//         ? new ServicesId.fromJson(json['services_id'])
//         : null;
//     subServicesId = json['sub_services_id'] != null
//         ? new ServicesId.fromJson(json['sub_services_id'])
//         : null;
//     country = json['country'];
//     locations = json['locations'];
//     notes = json['notes'];
//     date = json['date'];
//     code = json['code'];
//     lat = json['lat'];
//     lan = json['lan'];
//     status = json['status'];
//     photos = json['photos'].cast<String>();
//     avgOffers = json['avg_offers'];
//     isAccepted = json['isAccepted'];
//     acceptedPriceOffers = json['acceptedPriceOffers'] != null
//         ? new AcceptedPriceOffers.fromJson(json['acceptedPriceOffers'])
//         : null;
//     createDates = json['create_dates'] != null
//         ? new CreateDates.fromJson(json['create_dates'])
//         : null;
//     updateDates = json['update_dates'] != null
//         ? new UpdateDates.fromJson(json['update_dates'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.userRequestServices != null) {
//       data['user_request_services'] = this.userRequestServices!.toJson();
//     }
//     if (this.servicesId != null) {
//       data['services_id'] = this.servicesId!.toJson();
//     }
//     if (this.subServicesId != null) {
//       data['sub_services_id'] = this.subServicesId!.toJson();
//     }
//     data['country'] = this.country;
//     data['locations'] = this.locations;
//     data['notes'] = this.notes;
//     data['date'] = this.date;
//     data['code'] = this.code;
//     data['lat'] = this.lat;
//     data['lan'] = this.lan;
//     data['status'] = this.status;
//     data['photos'] = this.photos;
//     data['avg_offers'] = this.avgOffers;
//     data['isAccepted'] = this.isAccepted;
//     if (this.acceptedPriceOffers != null) {
//       data['acceptedPriceOffers'] = this.acceptedPriceOffers!.toJson();
//     }
//     if (this.createDates != null) {
//       data['create_dates'] = this.createDates!.toJson();
//     }
//     if (this.updateDates != null) {
//       data['update_dates'] = this.updateDates!.toJson();
//     }
//     return data;
//   }
// }
//
// class UserRequestServices {
//   int? id;
//   String? name;
//   String? photo;
//
//   UserRequestServices({this.id, this.name, this.photo});
//
//   UserRequestServices.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     photo = json['photo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['photo'] = this.photo;
//     return data;
//   }
// }
//
// class ServicesId {
//   int? id;
//   String? name;
//   bool? istabbed;
//
//   ServicesId({this.id, this.name, this.istabbed});
//
//   ServicesId.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     istabbed = json['istabbed'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['istabbed'] = this.istabbed;
//     return data;
//   }
// }
//
// class AcceptedPriceOffers {
//   int? priceOfferId;
//   UserRequestServices? provider;
//   int? providerRate;
//   int? price;
//   int? commission;
//   String? serviceDetails;
//   BidDuration? bidDuration;
//   String? status;
//
//   AcceptedPriceOffers(
//       {this.provider,
//         this.priceOfferId,
//         this.providerRate,
//         this.price,
//         this.commission,
//         this.serviceDetails,
//         this.bidDuration,
//         this.status});
//
//   AcceptedPriceOffers.fromJson(Map<String, dynamic> json) {
//     provider = json['provider'] != null
//         ? new UserRequestServices.fromJson(json['provider'])
//         : null;
//     priceOfferId=json['price_offer_id'];
//     providerRate = json['Provider_rate'];
//     price = json['price'];
//     commission = json['commission'];
//     serviceDetails = json['service_details'];
//     bidDuration = json['bid_duration'] != null
//         ? new BidDuration.fromJson(json['bid_duration'])
//         : null;
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.provider != null) {
//       data['provider'] = this.provider!.toJson();
//     }
//     data['price_offer_id']=this.priceOfferId;
//     data['Provider_rate'] = this.providerRate;
//     data['price'] = this.price;
//     data['commission'] = this.commission;
//     data['service_details'] = this.serviceDetails;
//     if (this.bidDuration != null) {
//       data['bid_duration'] = this.bidDuration!.toJson();
//     }
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class BidDuration {
//   String? bidDurationHuman;
//   String? bidDuration;
//
//   BidDuration({this.bidDurationHuman, this.bidDuration});
//
//   BidDuration.fromJson(Map<String, dynamic> json) {
//     bidDurationHuman = json['bid_duration_human'];
//     bidDuration = json['bid_duration'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bid_duration_human'] = this.bidDurationHuman;
//     data['bid_duration'] = this.bidDuration;
//     return data;
//   }
// }
//
// class CreateDates {
//   String? createdAtHuman;
//   String? createdAt;
//
//   CreateDates({this.createdAtHuman, this.createdAt});
//
//   CreateDates.fromJson(Map<String, dynamic> json) {
//     createdAtHuman = json['created_at_human'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['created_at_human'] = this.createdAtHuman;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }
//
// class UpdateDates {
//   String? updatedAtHuman;
//   String? updatedAt;
//
//   UpdateDates({this.updatedAtHuman, this.updatedAt});
//
//   UpdateDates.fromJson(Map<String, dynamic> json) {
//     updatedAtHuman = json['updated_at_human'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['updated_at_human'] = this.updatedAtHuman;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Links {
//   String? first;
//   String? last;
//   String? prev;
//   String? next;
//
//   Links({this.first, this.last, this.prev, this.next});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     first = json['first'];
//     last = json['last'];
//     prev = json['prev'];
//     next = json['next'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first'] = this.first;
//     data['last'] = this.last;
//     data['prev'] = this.prev;
//     data['next'] = this.next;
//     return data;
//   }
// }
//
// class Meta {
//   int? currentPage;
//   int? from;
//   int? lastPage;
//   List<Links>? links;
//   String? path;
//   int? perPage;
//   int? to;
//   int? total;
//
//   Meta(
//       {this.currentPage,
//         this.from,
//         this.lastPage,
//         this.links,
//         this.path,
//         this.perPage,
//         this.to,
//         this.total});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     if (json['links'] != null) {
//       links = <Links>[];
//       json['links'].forEach((v) {
//         links!.add(new Links.fromJson(v));
//       });
//     }
//     path = json['path'];
//     perPage = json['per_page'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     if (this.links != null) {
//       data['links'] = this.links!.map((v) => v.toJson()).toList();
//     }
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
//
// class CurrentOrderLinks {
//   String? url;
//   String? label;
//   bool? active;
//
//   CurrentOrderLinks({this.url, this.label, this.active});
//
//   CurrentOrderLinks.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['label'] = this.label;
//     data['active'] = this.active;
//     return data;
//   }
// }
class CurrentOrderClientModel {
  List<Data>? data;
  Links? links;
  Meta? meta;

  CurrentOrderClientModel({this.data, this.links, this.meta});

  CurrentOrderClientModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  UserRequestServices? userRequestServices;
  ServicesId? servicesId;
  ServicesId? subServicesId;
  String? country;
  String? locations;
  String? notes;
  String? date;
  String? code;
  String? lat;
  String? lan;
  String? status;
  int? cityId;
  List<String>? photos;
  int? avgOffers;
  bool? isAccepted;
  AcceptedPriceOffers? acceptedPriceOffers;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Data(
      {this.id,
        this.userRequestServices,
        this.servicesId,
        this.subServicesId,
        this.country,
        this.locations,
        this.notes,
        this.date,
        this.code,
        this.lat,
        this.lan,
        this.status,
        this.cityId,
        this.photos,
        this.avgOffers,
        this.isAccepted,
        this.acceptedPriceOffers,
        this.createDates,
        this.updateDates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userRequestServices = json['user_request_services'] != null
        ? new UserRequestServices.fromJson(json['user_request_services'])
        : null;
    servicesId = json['services_id'] != null
        ? new ServicesId.fromJson(json['services_id'])
        : null;
    subServicesId = json['sub_services_id'] != null
        ? new ServicesId.fromJson(json['sub_services_id'])
        : null;
    country = json['country'];
    locations = json['locations'];
    notes = json['notes'];
    date = json['date'];
    code = json['code'];
    lat = json['lat'];
    lan = json['lan'];
    status = json['status'];
    cityId = json['city_id'];
    photos = json['photos'].cast<String>();
    avgOffers = json['avg_offers'];
    isAccepted = json['isAccepted'];
    acceptedPriceOffers = json['acceptedPriceOffers'] != null
        ? new AcceptedPriceOffers.fromJson(json['acceptedPriceOffers'])
        : null;
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
    if (this.userRequestServices != null) {
      data['user_request_services'] = this.userRequestServices!.toJson();
    }
    if (this.servicesId != null) {
      data['services_id'] = this.servicesId!.toJson();
    }
    if (this.subServicesId != null) {
      data['sub_services_id'] = this.subServicesId!.toJson();
    }
    data['country'] = this.country;
    data['locations'] = this.locations;
    data['notes'] = this.notes;
    data['date'] = this.date;
    data['code'] = this.code;
    data['lat'] = this.lat;
    data['lan'] = this.lan;
    data['status'] = this.status;
    data['city_id'] = this.cityId;
    data['photos'] = this.photos;
    data['avg_offers'] = this.avgOffers;
    data['isAccepted'] = this.isAccepted;
    if (this.acceptedPriceOffers != null) {
      data['acceptedPriceOffers'] = this.acceptedPriceOffers!.toJson();
    }
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}

class UserRequestServices {
  int? id;
  String? name;
  String? photo;
  String? phone;

  UserRequestServices({this.id, this.name, this.photo, this.phone});

  UserRequestServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['phone'] = this.phone;
    return data;
  }
}

class ServicesId {
  int? id;
  String? name;
  bool? istabbed;

  ServicesId({this.id, this.name, this.istabbed});

  ServicesId.fromJson(Map<String, dynamic> json) {
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

class AcceptedPriceOffers {
  int? priceOfferId;
  Provider? provider;
  int? providerRate;
  int? price;
  int? commission;
  String? serviceDetails;
  BidDuration? bidDuration;
  String? status;

  AcceptedPriceOffers(
      {this.priceOfferId,
        this.provider,
        this.providerRate,
        this.price,
        this.commission,
        this.serviceDetails,
        this.bidDuration,
        this.status});

  AcceptedPriceOffers.fromJson(Map<String, dynamic> json) {
    priceOfferId = json['price_offer_id'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
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
    data['price_offer_id'] = this.priceOfferId;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
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
  // String? countryCode;
  // String? photo;
  // Null? email;
  // String? type;
  // String? status;
  // String? statusUser;
  // bool? isSubscribed;
  // String? location;
  // String? country;
  // double? rate;
  // int? noRate;
  // Null? notes;
  // Null? value;
  // Null? visionary;
  // Null? objectives;
  // ServicesId? license;
  // String? district;
  // String? lan;
  // String? lat;
  // String? fcmToken;
  // Null? experienceYears;
  // String? whatsappNumber;
  // List<Null>? projects;
  // List<Null>? achievements;
  // List<Null>? imagesAlbum;
  // List<Services>? services;
  // List<SubServices>? subServices;

  Provider(
      {this.id,
        this.name,
        this.phone,
        // this.countryCode,
        // this.photo,
        // this.email,
        // this.type,
        // this.status,
        // this.statusUser,
        // this.isSubscribed,
        // this.location,
        // this.country,
        // this.rate,
        // this.noRate,
        // this.notes,
        // this.value,
        // this.visionary,
        // this.objectives,
        // this.license,
        // this.district,
        // this.lan,
        // this.lat,
        // this.fcmToken,
        // this.experienceYears,
        // this.whatsappNumber,
        // this.projects,
        // this.achievements,
        // this.imagesAlbum,
        // this.services,
        // this.subServices
      });

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    // countryCode = json['country_code'];
    // photo = json['photo'];
    // email = json['email'];
    // type = json['type'];
    // status = json['status'];
    // statusUser = json['status_user'];
    // isSubscribed = json['is_subscribed'];
    // location = json['location'];
    // country = json['country'];
    // rate = json['rate'];
    // noRate = json['noRate'];
    // notes = json['notes'];
    // value = json['value'];
    // visionary = json['visionary'];
    // objectives = json['objectives'];
    // license = json['license'] != null
    //     ? new ServicesId.fromJson(json['license'])
    //     : null;
    // district = json['district'];
    // lan = json['lan'];
    // lat = json['lat'];
    // fcmToken = json['fcm_token'];
    // experienceYears = json['experience_years'];
    // whatsappNumber = json['whatsapp_number'];
    // if (json['projects'] != null) {
    //   projects = <Null>[];
    //   json['projects'].forEach((v) {
    //     projects!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['achievements'] != null) {
    //   achievements = <Null>[];
    //   json['achievements'].forEach((v) {
    //     achievements!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['images_album'] != null) {
    //   imagesAlbum = <Null>[];
    //   json['images_album'].forEach((v) {
    //     imagesAlbum!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['services'] != null) {
    //   services = <Services>[];
    //   json['services'].forEach((v) {
    //     services!.add(new Services.fromJson(v));
    //   });
    // }
    // if (json['sub_services'] != null) {
    //   subServices = <SubServices>[];
    //   json['sub_services'].forEach((v) {
    //     subServices!.add(new SubServices.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    // data['country_code'] = this.countryCode;
    // data['photo'] = this.photo;
    // data['email'] = this.email;
    // data['type'] = this.type;
    // data['status'] = this.status;
    // data['status_user'] = this.statusUser;
    // data['is_subscribed'] = this.isSubscribed;
    // data['location'] = this.location;
    // data['country'] = this.country;
    // data['rate'] = this.rate;
    // data['noRate'] = this.noRate;
    // data['notes'] = this.notes;
    // data['value'] = this.value;
    // data['visionary'] = this.visionary;
    // data['objectives'] = this.objectives;
    // if (this.license != null) {
    //   data['license'] = this.license!.toJson();
    // }
    // data['district'] = this.district;
    // data['lan'] = this.lan;
    // data['lat'] = this.lat;
    // data['fcm_token'] = this.fcmToken;
    // data['experience_years'] = this.experienceYears;
    // data['whatsapp_number'] = this.whatsappNumber;
    // if (this.projects != null) {
    //   data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    // }
    // if (this.achievements != null) {
    //   data['achievements'] = this.achievements!.map((v) => v.toJson()).toList();
    // }
    // if (this.imagesAlbum != null) {
    //   data['images_album'] = this.imagesAlbum!.map((v) => v.toJson()).toList();
    // }
    // if (this.services != null) {
    //   data['services'] = this.services!.map((v) => v.toJson()).toList();
    // }
    // if (this.subServices != null) {
    //   data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class BidDuration {
  String? bidDurationHuman;
  String? bidDuration;

  BidDuration({this.bidDurationHuman, this.bidDuration});

  BidDuration.fromJson(Map<String, dynamic> json) {
    bidDurationHuman = json['bid_duration_human'];
    bidDuration = json['bid_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bid_duration_human'] = this.bidDurationHuman;
    data['bid_duration'] = this.bidDuration;
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
  List<CurrentOrderLinks>? links;
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
      links = <CurrentOrderLinks>[];
      json['links'].forEach((v) {
        links!.add(new CurrentOrderLinks.fromJson(v));
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

class CurrentOrderLinks {
  String? url;
  String? label;
  bool? active;

  CurrentOrderLinks({this.url, this.label, this.active});

  CurrentOrderLinks.fromJson(Map<String, dynamic> json) {
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