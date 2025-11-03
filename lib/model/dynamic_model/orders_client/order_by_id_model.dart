class OrderByIdModel {
  Data? data;

  OrderByIdModel({this.data});

  OrderByIdModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  bool? isSent;
  List<PriceOffers>? priceOffers;
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
      this.isSent,
      this.lat,
      this.lan,
      this.status,
      this.cityId,
      this.photos,
      this.avgOffers,
      this.isAccepted,
      this.acceptedPriceOffers,
      this.createDates,
        this.priceOffers,
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
    isSent = json['isSent'];
    if (json['priceOffers'] != null) {
      priceOffers = <PriceOffers>[];
      json['priceOffers'].forEach((v) {
        priceOffers!.add(new PriceOffers.fromJson(v));
      });
    }
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
    data['isSent'] = this.isSent;
    data['lan'] = this.lan;
    data['status'] = this.status;
    data['city_id'] = this.cityId;
    data['photos'] = this.photos;
    data['avg_offers'] = this.avgOffers;
    data['isAccepted'] = this.isAccepted;
    if (this.priceOffers != null) {
      data['priceOffers'] = this.priceOffers!.map((v) => v.toJson()).toList();
    }
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
  String? photo;

  Provider({
    this.id,
    this.name,
    this.phone,
    this.photo,
  });

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    return data;
  }
}

class BidDuration {
  String? bidDurationHuman;
  String? bidDuration;
  String? remainingTime;

  BidDuration({this.bidDurationHuman, this.bidDuration,this.remainingTime});

  BidDuration.fromJson(Map<String, dynamic> json) {
    bidDurationHuman = json['bid_duration_human'];
    bidDuration = json['bid_duration'];
    remainingTime=json['remaining_time'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bid_duration_human'] = this.bidDurationHuman;
    data['bid_duration'] = this.bidDuration;
    data['remaining_time']=this.remainingTime;
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
class PriceOffers {
  int? priceOfferId;
  Provider? provider;
  int? providerRate;
  int? price;
  int? commission;
  String? serviceDetails;
  BidDuration? bidDuration;
  String? status;

  PriceOffers(
      {this.priceOfferId,
        this.provider,
        this.providerRate,
        this.price,
        this.commission,
        this.serviceDetails,
        this.bidDuration,
        this.status});

  PriceOffers.fromJson(Map<String, dynamic> json) {
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
