class ContactUsModel {
  String? message;
  Data? data;

  ContactUsModel({this.message, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
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
  Content? content;
  String? createdAt;
  String? updatedAt;

  Data({this.content, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Content {
  String? whatsApp;
  String? mail;
  String? facebook;
  String? twitter;
  String? instagram;
  String? phone;

  Content(
      {this.whatsApp,
        this.mail,
        this.facebook,
        this.twitter,
        this.instagram,
        this.phone});

  Content.fromJson(Map<String, dynamic> json) {
    whatsApp = json['whats_app'];
    mail = json['mail'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whats_app'] = this.whatsApp;
    data['mail'] = this.mail;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['phone'] = this.phone;
    return data;
  }
}