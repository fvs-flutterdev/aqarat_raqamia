class AllConversationsModel {
  List<AllConversationsDataModel>? allConversationsData;
  Links? links;
  Meta? meta;

  AllConversationsModel({this.allConversationsData, this.links, this.meta});

  AllConversationsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      allConversationsData = <AllConversationsDataModel>[];
      json['data'].forEach((v) {
        allConversationsData!.add(new AllConversationsDataModel.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allConversationsData != null) {
      data['data'] = this.allConversationsData!.map((v) => v.toJson()).toList();
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

class AllConversationsDataModel {
  int? id;
  Sender? sender;
  Sender? receiver;
  LastMessage? lastMessage;
  CreateDates? createDates;
  UpdateDates? updateDates;
  bool? istabbed;

  AllConversationsDataModel(
      {this.id,
      this.sender,
      this.receiver,
      this.createDates,
      this.updateDates,
        this.lastMessage,
      this.istabbed});

  AllConversationsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver =
        json['receiver'] != null ? new Sender.fromJson(json['receiver']) : null;
    lastMessage =
    json['last_message'] != null ? new LastMessage.fromJson(json['last_message']) : null;
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
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }

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

class Sender {
  int? id;
  String? name;
  String? photo;

  Sender({this.id, this.name, this.photo});

  Sender.fromJson(Map<String, dynamic> json) {
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

class AllChatLinks {
  String? url;
  String? label;
  bool? active;

  AllChatLinks({this.url, this.label, this.active});

  AllChatLinks.fromJson(Map<String, dynamic> json) {
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


class LastMessage {
  int? id;
  SenderLastMessage? senderLastMessage;
  int? chatId;
  String? body;
  String? messageType;
  String? type;
  bool? isTabbedLastMessage;
  CreateDatesLastMessage? createDatesLastMessage;
  UpdateDatesLastMessage? updateDatesLastMessage;

  LastMessage(
      {this.id,
        this.chatId,
        this.createDatesLastMessage,
        this.updateDatesLastMessage,
        this.body,
        this.messageType,
        this.type,
        this.isTabbedLastMessage,
        this.senderLastMessage});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    body = json['body'];
    messageType = json['message_type'];
    type = json['type'];
    isTabbedLastMessage = json['istabbed'];
    updateDatesLastMessage =
    json['update_dates'] != null ? new UpdateDatesLastMessage.fromJson(json['update_dates']) : null;
    createDatesLastMessage =
    json['create_dates'] != null ? new CreateDatesLastMessage.fromJson(json['create_dates']) : null;
    senderLastMessage =
    json['sender'] != null ? new SenderLastMessage.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.senderLastMessage != null) {
      data['sender'] = this.senderLastMessage!.toJson();
    }
    if (this.createDatesLastMessage != null) {
      data['create_dates'] = this.createDatesLastMessage!.toJson();
    }
    if (this.updateDatesLastMessage != null) {
      data['update_dates'] = this.updateDatesLastMessage!.toJson();
    }
    data['istabbed'] = this.isTabbedLastMessage;
    data['chat_id'] = this.chatId;
    data['type'] = this.type;
    data['message_type'] = this.messageType;
    data['body'] = this.body;
    return data;
  }
}
class SenderLastMessage {
  int? id;
  String? name;
  String? photo;

  SenderLastMessage({this.id, this.name, this.photo});

  SenderLastMessage.fromJson(Map<String, dynamic> json) {
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

class CreateDatesLastMessage {
  String? createdAtHuman;
  String? createdAt;

  CreateDatesLastMessage({this.createdAtHuman, this.createdAt});

  CreateDatesLastMessage.fromJson(Map<String, dynamic> json) {
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
class UpdateDatesLastMessage {
  String? updatedAtHuman;
  String? updatedAt;

  UpdateDatesLastMessage({this.updatedAtHuman, this.updatedAt});

  UpdateDatesLastMessage.fromJson(Map<String, dynamic> json) {
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
