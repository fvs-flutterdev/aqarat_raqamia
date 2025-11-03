class NewOrderClientModel {
  List<Data>? data;
  Links? links;
  Meta? meta;

  NewOrderClientModel({this.data, this.links, this.meta});

  NewOrderClientModel.fromJson(Map<String, dynamic> json) {
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
 // List<Null>? rates;
  String? country;
  String? locations;
  String? notes;
  String? date;
  String? code;
  String? lat;
  String? lan;
  String? status;
  List<String>? photos;
//  Null? avgOffers;
  bool? isAccepted;
 // List<Null>? acceptedPriceOffers;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Data(
      {this.id,
        this.userRequestServices,
        this.servicesId,
        this.subServicesId,
       // this.rates,
        this.country,
        this.locations,
        this.notes,
        this.date,
        this.code,
        this.lat,
        this.lan,
        this.status,
        this.photos,
      //  this.avgOffers,
        this.isAccepted,
        //this.acceptedPriceOffers,
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
    // if (json['rates'] != null) {
    //   rates = <Null>[];
    //   json['rates'].forEach((v) {
    //     rates!.add(new Null.fromJson(v));
    //   });
    // }
    country = json['country'];
    locations = json['locations'];
    notes = json['notes'];
    date = json['date'];
    code = json['code'];
    lat = json['lat'];
    lan = json['lan'];
    status = json['status'];
    photos = json['photos'].cast<String>();
   // avgOffers = json['avg_offers'];
    isAccepted = json['isAccepted'];
    // if (json['acceptedPriceOffers'] != null) {
    //   acceptedPriceOffers = <Null>[];
    //   json['acceptedPriceOffers'].forEach((v) {
    //     acceptedPriceOffers!.add(new Null.fromJson(v));
    //   });
    // }
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
    // if (this.rates != null) {
    //   data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    // }
    data['country'] = this.country;
    data['locations'] = this.locations;
    data['notes'] = this.notes;
    data['date'] = this.date;
    data['code'] = this.code;
    data['lat'] = this.lat;
    data['lan'] = this.lan;
    data['status'] = this.status;
    data['photos'] = this.photos;
    //data['avg_offers'] = this.avgOffers;
    data['isAccepted'] = this.isAccepted;
    // if (this.acceptedPriceOffers != null) {
    //   data['acceptedPriceOffers'] =
    //       this.acceptedPriceOffers!.map((v) => v.toJson()).toList();
    // }
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

class NewOrdersLinks {
  String? url;
  String? label;
  bool? active;

  NewOrdersLinks({this.url, this.label, this.active});

  NewOrdersLinks.fromJson(Map<String, dynamic> json) {
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