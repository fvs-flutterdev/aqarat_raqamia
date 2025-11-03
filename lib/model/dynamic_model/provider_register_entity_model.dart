class ProviderRegisterEntityModel {
  List<Services>? services;
  List<SubServices>? subServices;
  List<Licenses>? licenses;
  List<Experience>? experience;

  ProviderRegisterEntityModel(
      {this.services, this.subServices, this.licenses, this.experience});

  ProviderRegisterEntityModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(new SubServices.fromJson(v));
      });
    }
    if (json['licenses'] != null) {
      licenses = <Licenses>[];
      json['licenses'].forEach((v) {
        licenses!.add(new Licenses.fromJson(v));
      });
    }
    if (json['experience'] != null) {
      experience = <Experience>[];
      json['experience'].forEach((v) {
        experience!.add(new Experience.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.subServices != null) {
      data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    }
    if (this.licenses != null) {
      data['licenses'] = this.licenses!.map((v) => v.toJson()).toList();
    }
    if (this.experience != null) {
      data['experience'] = this.experience!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? name;
  bool? istabbed;

  Services({this.id, this.name, this.istabbed});

  Services.fromJson(Map<String, dynamic> json) {
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

class SubServices {
  int? id;
  String? name;
  bool? istabbed;

  SubServices({this.id, this.name, this.istabbed});

  SubServices.fromJson(Map<String, dynamic> json) {
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
class Licenses {
  int? id;
  String? name;
  bool? istabbed;

  Licenses({this.id, this.name, this.istabbed});

  Licenses.fromJson(Map<String, dynamic> json) {
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



class Experience {
  String? title;
  bool? istabbed;

  Experience({this.title, this.istabbed});

  Experience.fromJson(Map<String, dynamic> json) {
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