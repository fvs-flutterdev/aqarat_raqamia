class AboutUsModel {
  String? message;
  Data? data;

  AboutUsModel({this.message, this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  AboutUsData? data;
  String? createdAt;
  String? updatedAt;

  Data({this.data, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AboutUsData.fromJson(json['data']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AboutUsData {
  String? content;
  String? mail;
  String? phone;

  AboutUsData({this.content, this.mail, this.phone});

  AboutUsData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    mail = json['mail'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['mail'] = this.mail;
    data['phone'] = this.phone;
    return data;
  }
}