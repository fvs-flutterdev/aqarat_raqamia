class ResourceCreateModel {
  List<Features>? features;
  List<AdType>? adType;
  List<Type>? type;
  List<RoomsNumber>? roomsNumber;
  List<ToiletNumber>? toiletNumber;
  List<Prolongation>? prolongation;
  List<LivingRoom>? livingRoom;

  ResourceCreateModel(
      {this.features,
        this.adType,
        this.type,
        this.roomsNumber,
        this.toiletNumber,
        this.prolongation});

  ResourceCreateModel.fromJson(Map<String, dynamic> json) {
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    if (json['ad_type'] != null) {
      adType = <AdType>[];
      json['ad_type'].forEach((v) {
        adType!.add(new AdType.fromJson(v));
      });
    }
    if (json['type'] != null) {
      type = <Type>[];
      json['type'].forEach((v) {
        type!.add(new Type.fromJson(v));
      });
    }
    if (json['rooms_number'] != null) {
      roomsNumber = <RoomsNumber>[];
      json['rooms_number'].forEach((v) {
        roomsNumber!.add(new RoomsNumber.fromJson(v));
      });
    }
    if (json['living_room'] != null) {
      livingRoom = <LivingRoom>[];
      json['living_room'].forEach((v) {
        livingRoom!.add(new LivingRoom.fromJson(v));
      });
    }
    if (json['toilet_number'] != null) {
      toiletNumber = <ToiletNumber>[];
      json['toilet_number'].forEach((v) {
        toiletNumber!.add(new ToiletNumber.fromJson(v));
      });
    }
    if (json['prolongation'] != null) {
      prolongation = <Prolongation>[];
      json['prolongation'].forEach((v) {
        prolongation!.add(new Prolongation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    if (this.adType != null) {
      data['ad_type'] = this.adType!.map((v) => v.toJson()).toList();
    }
    if (this.type != null) {
      data['type'] = this.type!.map((v) => v.toJson()).toList();
    }
    if (this.roomsNumber != null) {
      data['rooms_number'] = this.roomsNumber!.map((v) => v.toJson()).toList();
    }
    if (this.toiletNumber != null) {
      data['toilet_number'] =
          this.toiletNumber!.map((v) => v.toJson()).toList();
    }
    if (this.prolongation != null) {
      data['prolongation'] = this.prolongation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  int? id;
  String? name;
  String? photo;
  CreateDates? createDates;
  UpdateDates? updateDates;
  bool? istabbed;

  Features(
      {this.id,
        this.name,
        this.photo,
        this.createDates,
        this.updateDates,
        this.istabbed});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
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
class ToiletNumber {
  String? title;
  bool istabbed=false;

  ToiletNumber({this.title, this.istabbed=false});

  ToiletNumber.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['istabbed'] = this.istabbed;
    return data;
  }
}
class AdType {
  int? id;
  String? name;
  String? photo;
  bool istabbed=false;

  AdType({this.id, this.name, this.photo, this.istabbed=false});

  AdType.fromJson(Map<String, dynamic> json) {
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
  bool istabbed=false;

  Type({this.id, this.name, this.istabbed=false});

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

class RoomsNumber {
  String? title;
  bool istabbed=false;

  RoomsNumber({this.title, this.istabbed=false});

  RoomsNumber.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['istabbed'] = this.istabbed;
    return data;
  }
}

class LivingRoom {
  String? title;
  bool istabbed=false;

  LivingRoom({this.title, this.istabbed=false});

  LivingRoom.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['istabbed'] = this.istabbed;
    return data;
  }
}

class Prolongation {
  int? id;
  String? title;
  bool istabbed=false;

  Prolongation({this.id, this.title, this.istabbed=false});

  Prolongation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['istabbed'] = this.istabbed;
    return data;
  }
}