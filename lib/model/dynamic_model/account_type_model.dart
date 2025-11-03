class AccountTypeModel {
  String? message;
  List<Data>? data;

  AccountTypeModel({this.message, this.data});

  AccountTypeModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? image;
  String? title;
  String? category;
  String? description;
  bool? istabbed;

  Data(
      {this.id,
      this.image,
      this.title,
      this.category,
      this.description,
      this.istabbed});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    category = json['category'];
    description = json['description'];
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['category'] = this.category;
    data['description'] = this.description;
    data['istabbed'] = this.istabbed;
    return data;
  }
}
