class AllOldOrdersProvider {
  List<OldOrdersProviders>? data;
  Links? links;
  Meta? meta;

  AllOldOrdersProvider({this.data, this.links, this.meta});

  AllOldOrdersProvider.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OldOrdersProviders>[];
      json['data'].forEach((v) {
        data!.add(new OldOrdersProviders.fromJson(v));
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

class OldOrdersProviders {
  int? id;
  UserRequestServices? userRequestServices;
  ServicesId? servicesId;
  ServicesId? subServicesId;
  List<Rates>? rates;
  String? country;
  String? locations;
  String? cityName;
  String? notes;
  String? date;
  String? code;
  String? lat;
  String? lan;
  String? status;
  String? orderType;
  List<String>? photos;
  AcceptedPriceOffers? acceptedPriceOffers;
  CreateDates? createDates;
  UpdateDates? updateDates;

  OldOrdersProviders(
      {this.id,
        this.userRequestServices,
        this.servicesId,
        this.subServicesId,
        this.rates,
        this.country,
        this.locations,
        this.notes,
        this.date,
        this.code,
        this.orderType,
        this.cityName,
        this.lat,
        this.lan,
        this.status,
        this.photos,
        this.acceptedPriceOffers,
        this.createDates,
        this.updateDates});

  OldOrdersProviders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userRequestServices = json['user_request_services'] != null
        ? new UserRequestServices.fromJson(json['user_request_services'])
        : null;
    servicesId = json['services_id'] != null
        ? new ServicesId.fromJson(json['services_id'])
        : null;
    cityName=json['city_name'];
    subServicesId = json['sub_services_id'] != null
        ? new ServicesId.fromJson(json['sub_services_id'])
        : null;
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates!.add(new Rates.fromJson(v));
      });
    }
    country = json['country'];
    locations = json['locations'];
    notes = json['notes'];
    date = json['date'];
    code = json['code'];
    lat = json['lat'];
    orderType=json['type'];
    lan = json['lan'];
    status = json['status'];
    photos = json['photos'].cast<String>();
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
    if (this.rates != null) {
      data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    }
    data['country'] = this.country;
    data['city_name'] = this.cityName;
    data['locations'] = this.locations;
    data['notes'] = this.notes;
    data['date'] = this.date;
    data['code'] = this.code;
    data['lat'] = this.lat;
    data['lan'] = this.lan;
    data['type']=this.orderType;
    data['status'] = this.status;
    data['photos'] = this.photos;
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

  UserRequestServices({this.id, this.name, this.photo});

  UserRequestServices.fromJson(Map<String, dynamic> json) {
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
class Rates {
  int? id;
  String? username;
  String? rate;
  String? notes;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Rates(
      {this.id,
        this.username,
        this.rate,
        this.notes,
        this.createDates,
        this.updateDates});

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    rate = json['rate'];
    notes = json['notes'];
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
    data['username'] = this.username;
    data['rate'] = this.rate;
    data['notes'] = this.notes;
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}
class AcceptedPriceOffers {
  UserRequestServices? provider;
  int? price;
  int? commission;
  String? serviceDetails;
  BidDuration? bidDuration;
  String? status;

  AcceptedPriceOffers(
      {this.provider,
        this.price,
        this.commission,
        this.serviceDetails,
        this.bidDuration,
        this.status});

  AcceptedPriceOffers.fromJson(Map<String, dynamic> json) {
    provider = json['provider'] != null
        ? new UserRequestServices.fromJson(json['provider'])
        : null;
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

class OldOrdersLinks {
  String? url;
  String? label;
  bool? active;

  OldOrdersLinks({this.url, this.label, this.active});

  OldOrdersLinks.fromJson(Map<String, dynamic> json) {
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