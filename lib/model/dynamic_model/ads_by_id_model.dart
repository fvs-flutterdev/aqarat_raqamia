class AdsByIdModel {
  Data? data;

  AdsByIdModel({this.data});

  AdsByIdModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
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
  List<Null>? featureAds;
  String? usage;
  String? area;
  String? frontage;
  String? services;
  int? age;
  String? region;
  String? city;
  String? district;
  String? additionalRequirements;
  String? desiredPropertySpecifications;
  String? streetWidth;
  String? planNumber;
  String? parcelNumber;
  String? livingRoomsNumber;
  dynamic floorsNumber;
  bool? parkingSpaces;
  dynamic commercialUnitsNumber;
  dynamic wellsNumber;
  dynamic treesAndPalmsNumber;
  bool? promoted;
  CreateDates? createDates;
  UpdateDates? updateDates;
  List<AdditionalFeatures>? additionalFeatures;
  List<AdComments>? adComments;

  Data(
      {this.id,
      this.name,
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
      this.usage,
      this.area,
      this.frontage,
      this.services,
      this.age,
      this.region,
      this.city,
      this.district,
      this.additionalRequirements,
      this.desiredPropertySpecifications,
      this.streetWidth,
      this.planNumber,
      this.parcelNumber,
      this.livingRoomsNumber,
      this.floorsNumber,
      this.parkingSpaces,
      this.commercialUnitsNumber,
      this.wellsNumber,
      this.treesAndPalmsNumber,
      this.promoted,
      this.createDates,
      this.updateDates,
      this.additionalFeatures,
      this.adComments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    usage = json['usage'] ?? '';
    area = json['area'] ?? '';
    frontage = json['frontage'] ?? '';
    services = json['services'] ?? '';
    age = json['age'];
    region = json['region'] ?? '';
    city = json['city'] ?? '';
    district = json['district'] ?? '';
    additionalRequirements = json['additional_requirements'] ?? '';
    desiredPropertySpecifications =
        json['desired_property_specifications'] ?? '';
    streetWidth = json['street_width'] ?? '';
    planNumber = json['plan_number'] ?? '';
    parcelNumber = json['parcel_number'] ?? '';
    livingRoomsNumber = json['living_rooms_number'] ?? '';
    floorsNumber = json['floors_number'] ?? '';
    parkingSpaces = json['parking_spaces'];
    commercialUnitsNumber = json['commercial_units_number'] ?? '';
    wellsNumber = json['wells_number'] ?? '';
    treesAndPalmsNumber = json['trees_and_palms_number'] ?? '';
    promoted = json['promoted'];
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
    if (json['additional_features'] != null) {
      additionalFeatures = <AdditionalFeatures>[];
      json['additional_features'].forEach((v) {
        additionalFeatures!.add(new AdditionalFeatures.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      adComments = <AdComments>[];
      json['comments'].forEach((v) {
        adComments!.add(new AdComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
    data['usage'] = this.usage;
    data['area'] = this.area;
    data['frontage'] = this.frontage;
    data['services'] = this.services;
    data['age'] = this.age;
    data['region'] = this.region;
    data['city'] = this.city;
    data['district'] = this.district;
    data['additional_requirements'] = this.additionalRequirements;
    data['desired_property_specifications'] =
        this.desiredPropertySpecifications;
    data['street_width'] = this.streetWidth;
    data['plan_number'] = this.planNumber;
    data['parcel_number'] = this.parcelNumber;
    data['living_rooms_number'] = this.livingRoomsNumber;
    data['floors_number'] = this.floorsNumber;
    data['parking_spaces'] = this.parkingSpaces;
    data['commercial_units_number'] = this.commercialUnitsNumber;
    data['wells_number'] = this.wellsNumber;
    data['trees_and_palms_number'] = this.treesAndPalmsNumber;
    data['promoted'] = this.promoted;
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    if (this.additionalFeatures != null) {
      data['additional_features'] =
          this.additionalFeatures!.map((v) => v.toJson()).toList();
    }
    if (this.adComments != null) {
      data['comments'] = this.adComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAds {
  int? id;
  String? name;
  String? photo;
  String? phone;

  UserAds({this.id, this.name, this.photo, this.phone});

  UserAds.fromJson(Map<String, dynamic> json) {
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

class CategoryAds {
  int? id;
  String? name;
  String? notes;
  String? photo;
  bool? istabbed;

  CategoryAds({this.id, this.name, this.notes, this.photo, this.istabbed});

  CategoryAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    notes = json['notes'];
    photo = json['photo'];
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['notes'] = this.notes;
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

class AdditionalFeatures {
  int? id;
  String? name;
  String? image;

  AdditionalFeatures({this.id, this.name, this.image});

  AdditionalFeatures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class AdComments {
  int? id;
  int? userId;
  String? content;
  String? name;
  String? image;
  double? averageRate;
  String? createdAt;
  String? updatedAt;

  AdComments(
      {this.id,
      this.name,
      this.image,
      this.userId,
      this.content,
      this.averageRate,
      this.updatedAt,
      this.createdAt});

  AdComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['user_name'];
    image = json['user_photo'];
    content = json['content'];
    averageRate = json['average_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['user_name'] = this.name;
    data['user_photo'] = this.image;
    data['average_rating'] = this.averageRate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
