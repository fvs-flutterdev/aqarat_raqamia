class MyComplaintsModel {
  List<Complaints>? complaints;

  MyComplaintsModel({this.complaints});

  MyComplaintsModel.fromJson(Map<String, dynamic> json) {
    if (json['complaints'] != null) {
      complaints = <Complaints>[];
      json['complaints'].forEach((v) {
        complaints!.add(new Complaints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaints != null) {
      data['complaints'] = this.complaints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Complaints {
  int? id;
  int? userId;
  String? email;
  String? subject;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<Responses>? responses;

  Complaints(
      {this.id,
        this.userId,
        this.email,
        this.subject,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.responses});

  Complaints.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    email = json['email'];
    subject = json['subject'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['responses'] != null) {
      responses = <Responses>[];
      json['responses'].forEach((v) {
        responses!.add(new Responses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.responses != null) {
      data['responses'] = this.responses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Responses {
  int? id;
  int? complaintId;
  int? userId;
  String? response;
  String? createdAt;
  String? updatedAt;

  Responses(
      {this.id,
        this.complaintId,
        this.userId,
        this.response,
        this.createdAt,
        this.updatedAt});

  Responses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    complaintId = json['complaint_id'];
    userId = json['user_id'];
    response = json['response'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['complaint_id'] = this.complaintId;
    data['user_id'] = this.userId;
    data['response'] = this.response;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}