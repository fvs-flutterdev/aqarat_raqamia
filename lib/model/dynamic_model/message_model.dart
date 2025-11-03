// class MessageProvider {
//   Messages? message;
//   CreateMessage? createDates;
//   UpdateMessage? updateDates;
//
//
//
//   MessageProvider({this.message});
//
//   MessageProvider.fromJson(Map<String, dynamic> json) {
//     message =
//     json['message'] != null ? new Messages.fromJson(json['data']) : null;
//     //data=json[]
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.message != null) {
//       data['data'] = this.message!.toJson();
//     }
//     return data;
//   }
// }
//
// class Messages {
//   int? id;
//   String? body;
//   String? messageType;
//   String? type;
//   CreateMessage? createDates;
//   UpdateMessage? updateDates;
//   bool? istabbed;
//
//   Messages(
//       {this.id,
//         this.body,
//         this.messageType,
//         this.type,
//         this.createDates,
//         this.updateDates,
//         this.istabbed});
//
//   Messages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     body = json['body'];
//     messageType = json['message_type'];
//     type = json['type'];
//     createDates = json['create_dates'] != null
//         ? new CreateMessage.fromJson(json['create_dates'])
//         : null;
//     updateDates = json['update_dates'] != null
//         ? new UpdateMessage.fromJson(json['update_dates'])
//         : null;
//     istabbed = json['istabbed'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['body'] = this.body;
//     data['message_type'] = this.messageType;
//     data['type'] = this.type;
//     if (this.createDates != null) {
//       data['create_dates'] = this.createDates!.toJson();
//     }
//     if (this.updateDates != null) {
//       data['update_dates'] = this.updateDates!.toJson();
//     }
//     data['istabbed'] = this.istabbed;
//     return data;
//   }
// }
//
// class CreateMessage {
//   String? createdAtHuman;
//   String? createdAt;
//
//   CreateMessage({this.createdAtHuman, this.createdAt});
//
//   CreateMessage.fromJson(Map<String, dynamic> json) {
//     createdAtHuman = json['created_at_human'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['created_at_human'] = this.createdAtHuman;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }
//
// class UpdateMessage {
//   String? updatedAtHuman;
//   String? updatedAt;
//
//   UpdateMessage({this.updatedAtHuman, this.updatedAt});
//
//   UpdateMessage.fromJson(Map<String, dynamic> json) {
//     updatedAtHuman = json['updated_at_human'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['updated_at_human'] = this.updatedAtHuman;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

class MessageProvider {
  Messages? data;
  CreateDates? createDates;
  UpdateDates? updateDates;
  MessageProvider({this.data});

  MessageProvider.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Messages.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Messages {
  int? id;
  String? body;
  String? messageType;
  String? type;
  CreateDates? createDates;
  UpdateDates? updateDates;
  bool? istabbed;

  Messages(
      {this.id,
        this.body,
        this.messageType,
        this.type,
        this.createDates,
        this.updateDates,
        this.istabbed});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    messageType = json['message_type'];
    type = json['type'];
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
    data['body'] = this.body;
    data['message_type'] = this.messageType;
    data['type'] = this.type;
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