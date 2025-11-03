// class NotificationsModel {
//   List<Data>? data;
//   Links? links;
//   Meta? meta;
//
//   NotificationsModel({this.data, this.links, this.meta});
//
//   NotificationsModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     links = json['links'] != null ? new Links.fromJson(json['links']) : null;
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     if (this.links != null) {
//       data['links'] = this.links!.toJson();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? title;
//   String? body;
//   CreateDates? createDates;
//   UpdateDates? updateDates;
//   bool? istabbed;
//
//   Data(
//       {this.id,
//         this.title,
//         this.body,
//         this.createDates,
//         this.updateDates,
//         this.istabbed});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     body = json['body'];
//     createDates = json['create_dates'] != null
//         ? new CreateDates.fromJson(json['create_dates'])
//         : null;
//     updateDates = json['update_dates'] != null
//         ? new UpdateDates.fromJson(json['update_dates'])
//         : null;
//     istabbed = json['istabbed'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['body'] = this.body;
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
// class CreateDates {
//   String? createdAtHuman;
//   String? createdAt;
//
//   CreateDates({this.createdAtHuman, this.createdAt});
//
//   CreateDates.fromJson(Map<String, dynamic> json) {
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
// class UpdateDates {
//   String? updatedAtHuman;
//   String? updatedAt;
//
//   UpdateDates({this.updatedAtHuman, this.updatedAt});
//
//   UpdateDates.fromJson(Map<String, dynamic> json) {
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
//
// class Links {
//   String? first;
//   String? last;
//   String? prev;
//   String? next;
//
//   Links({this.first, this.last, this.prev, this.next});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     first = json['first'];
//     last = json['last'];
//     prev = json['prev'];
//     next = json['next'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first'] = this.first;
//     data['last'] = this.last;
//     data['prev'] = this.prev;
//     data['next'] = this.next;
//     return data;
//   }
// }
//
// class Meta {
//   int? currentPage;
//   int? from;
//   int? lastPage;
//   List<Links>? links;
//   String? path;
//   int? perPage;
//   int? to;
//   int? total;
//
//   Meta(
//       {this.currentPage,
//         this.from,
//         this.lastPage,
//         this.links,
//         this.path,
//         this.perPage,
//         this.to,
//         this.total});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     if (json['links'] != null) {
//       links = <Links>[];
//       json['links'].forEach((v) {
//         links!.add(new Links.fromJson(v));
//       });
//     }
//     path = json['path'];
//     perPage = json['per_page'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     if (this.links != null) {
//       data['links'] = this.links!.map((v) => v.toJson()).toList();
//     }
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
//
// class NotificationsLinks {
//   String? url;
//   String? label;
//   bool? active;
//
//   NotificationsLinks({this.url, this.label, this.active});
//
//   NotificationsLinks.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['label'] = this.label;
//     data['active'] = this.active;
//     return data;
//   }
// }
///
// class NotificationsModel {
//   List<Data>? data;
//   Links? links;
//   Meta? meta;
//
//   NotificationsModel({this.data, this.links, this.meta});
//
//   NotificationsModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     links = json['links'] != null ? new Links.fromJson(json['links']) : null;
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     if (this.links != null) {
//       data['links'] = this.links!.toJson();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? title;
//   String? body;
//   PayLoadData? payLoadData;
//   CreateDates? createDates;
//   UpdateDates? updateDates;
//   bool? istabbed;
//
//   Data(
//       {this.id,
//         this.title,
//         this.body,
//         this.payLoadData,
//         this.createDates,
//         this.updateDates,
//         this.istabbed});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     body = json['body'];
//     payLoadData = json['data'] != null ? new PayLoadData.fromJson(json['data']) : null;
//     createDates = json['create_dates'] != null
//         ? new CreateDates.fromJson(json['create_dates'])
//         : null;
//     updateDates = json['update_dates'] != null
//         ? new UpdateDates.fromJson(json['update_dates'])
//         : null;
//     istabbed = json['istabbed'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['body'] = this.body;
//     if (this.payLoadData != null) {
//       data['data'] = this.payLoadData!.toJson();
//     }
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
// class PayLoadData {
//   int? userId;
//   dynamic requestServiceId;
//   String? serviceDetails;
//   dynamic price;
//   int? commission;
//   String? bidDuration;
//   String? updatedAt;
//   String? createdAt;
//   int? id;
//
//   PayLoadData(
//       {this.userId,
//         this.requestServiceId,
//         this.serviceDetails,
//         this.price,
//         this.commission,
//         this.bidDuration,
//         this.updatedAt,
//         this.createdAt,
//         this.id});
//
//   PayLoadData.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     requestServiceId = json['request_service_id'];
//     serviceDetails = json['service_details'];
//     price = json['price'];
//     commission = json['commission'];
//     bidDuration = json['bid_duration'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['request_service_id'] = this.requestServiceId;
//     data['service_details'] = this.serviceDetails;
//     data['price'] = this.price;
//     data['commission'] = this.commission;
//     data['bid_duration'] = this.bidDuration;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     data['id'] = this.id;
//     return data;
//   }
// }
//
// class CreateDates {
//   String? createdAtHuman;
//   String? createdAt;
//
//   CreateDates({this.createdAtHuman, this.createdAt});
//
//   CreateDates.fromJson(Map<String, dynamic> json) {
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
// class UpdateDates {
//   String? updatedAtHuman;
//   String? updatedAt;
//
//   UpdateDates({this.updatedAtHuman, this.updatedAt});
//
//   UpdateDates.fromJson(Map<String, dynamic> json) {
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
//
// class Links {
//   String? first;
//   String? last;
//   String? prev;
//   String? next;
//
//   Links({this.first, this.last, this.prev, this.next});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     first = json['first'];
//     last = json['last'];
//     prev = json['prev'];
//     next = json['next'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first'] = this.first;
//     data['last'] = this.last;
//     data['prev'] = this.prev;
//     data['next'] = this.next;
//     return data;
//   }
// }
//
// class Meta {
//   int? currentPage;
//   int? from;
//   int? lastPage;
//   List<Links>? links;
//   String? path;
//   int? perPage;
//   int? to;
//   int? total;
//
//   Meta(
//       {this.currentPage,
//         this.from,
//         this.lastPage,
//         this.links,
//         this.path,
//         this.perPage,
//         this.to,
//         this.total});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     if (json['links'] != null) {
//       links = <Links>[];
//       json['links'].forEach((v) {
//         links!.add(new Links.fromJson(v));
//       });
//     }
//     path = json['path'];
//     perPage = json['per_page'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     if (this.links != null) {
//       data['links'] = this.links!.map((v) => v.toJson()).toList();
//     }
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
//
// class NotificationsLinks {
//   String? url;
//   String? label;
//   bool? active;
//
//   NotificationsLinks({this.url, this.label, this.active});
//
//   NotificationsLinks.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['label'] = this.label;
//     data['active'] = this.active;
//     return data;
//   }
// }




class NotificationsModel {
  List<Data>? data;
  Links? links;
  Meta? meta;

  NotificationsModel({this.data, this.links, this.meta});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? title;
  String? body;
  PayLoadData? payLoadData;
  CreateDates? createDates;
  UpdateDates? updateDates;
 // bool? istabbed;

  Data(
      {this.id,
        this.title,
        this.body,
        this.payLoadData,
        this.createDates,
        this.updateDates,
       // this.istabbed
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    payLoadData = json['data'] != null ? new PayLoadData.fromJson(json['data']) : null;
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
   // istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    if (this.payLoadData != null) {
      data['data'] = this.payLoadData!.toJson();
    }
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
 //   data['istabbed'] = this.istabbed;
    return data;
  }
}

class PayLoadData {
  String? receiverId;

  ///id الشخص الي طلب الخدمه/ id مستقبل الرسالة
  String? chatRoomId;

  ///id روم الشات / id الطلب
  String? chatType;

  ///نوع الرساله في الشات سواء صوره او ميديا
  String? senderName;

  ///اسم الراسل / اسم طالب الخدمة
  String? notificationType;

  ///نوع الإشعار سواء اشعار محادثه - طلب - عادي
  String? senderId;

  /// id راسل الرساله / id الشخص الي هينفذ الخدمه
  //User? user;

  PayLoadData(
      {this.senderId,
        this.chatRoomId,
        this.chatType,
        this.senderName,
        this.notificationType,
        this.receiverId,
      //  this.user
      });

  PayLoadData.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiver_id'];
    chatRoomId = json['chat_room_id'];
    chatType = json['msg_type'];
    senderName = json['sender_name'];
    notificationType = json['type'];
    senderId = json['sender_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiver_id'] = this.receiverId;
    data['chat_room_id'] = this.chatRoomId;
    data['msg_type'] = this.chatType;
    data['sender_name'] = this.senderName;
    data['type'] = this.notificationType;
    data['sender_id'] = this.senderId;
    return data;
  }
}

// class RequestedService {
//   dynamic id;
//   dynamic cityId;
//   dynamic userId;
//   dynamic providerId;
//   dynamic servicesId;
//   dynamic subServicesId;
//   String? country;
//   String? locations;
//   String? notes;
//   String? notesEn;
//   String? date;
//   String? code;
//   String? lan;
//   String? lat;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   RequestedService(
//       {this.id,
//         this.cityId,
//         this.userId,
//         this.providerId,
//         this.servicesId,
//         this.subServicesId,
//         this.country,
//         this.locations,
//         this.notes,
//         this.notesEn,
//         this.date,
//         this.code,
//         this.lan,
//         this.lat,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   RequestedService.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     cityId = json['city_id'];
//     userId = json['user_id'];
//     providerId = json['provider_id'];
//     servicesId = json['services_id'];
//     subServicesId = json['sub_services_id'];
//     country = json['country'];
//     locations = json['locations'];
//     notes = json['notes'];
//     notesEn = json['notes_en'];
//     date = json['date'];
//     code = json['code'];
//     lan = json['lan'];
//     lat = json['lat'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['city_id'] = this.cityId;
//     data['user_id'] = this.userId;
//     data['provider_id'] = this.providerId;
//     data['services_id'] = this.servicesId;
//     data['sub_services_id'] = this.subServicesId;
//     data['country'] = this.country;
//     data['locations'] = this.locations;
//     data['notes'] = this.notes;
//     data['notes_en'] = this.notesEn;
//     data['date'] = this.date;
//     data['code'] = this.code;
//     data['lan'] = this.lan;
//     data['lat'] = this.lat;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// // class User {
// //   int? id;
// //   String? name;
// //   String? photo;
// //   String? countryCode;
// //   String? phone;
// //   String? whatsappNumber;
// //   String? email;
// //   String? emailVerifiedAt;
// //   String? type;
// //   String? status;
// //   String? statusUser;
// //   String? location;
// //   String? country;
// //   double? rate;
// //   String? notes;
// //   String? value;
// //   // Null? experienceYears;
// //   // Null? visionary;
// //   // Null? objectives;
// //   // Null? typeLicense;
// //   // int? licenseId;
// //   // String? district;
// //   // String? lan;
// //   // String? lat;
// //   // String? fcmToken;
// //   // Null? balance;
// //   String? createdAt;
// //   String? updatedAt;
// //   String? promoted;
// //   String? promotionBidDuration;
// //   int? isBlocked;
// //
// //   User(
// //       {this.id,
// //         this.name,
// //         this.photo,
// //         this.countryCode,
// //         this.phone,
// //         this.whatsappNumber,
// //         this.email,
// //         this.emailVerifiedAt,
// //         this.type,
// //         this.status,
// //         this.statusUser,
// //         this.location,
// //         this.country,
// //         this.rate,
// //         this.notes,
// //         this.value,
// //         // this.experienceYears,
// //         // this.visionary,
// //         // this.objectives,
// //         // this.typeLicense,
// //         // this.licenseId,
// //         // this.district,
// //         // this.lan,
// //         // this.lat,
// //         // this.fcmToken,
// //         // this.balance,
// //         this.createdAt,
// //         this.updatedAt,
// //         this.promoted,
// //         this.promotionBidDuration,
// //         this.isBlocked});
// //
// //   User.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     name = json['name'];
// //     photo = json['photo'];
// //     countryCode = json['country_code'];
// //     phone = json['phone'];
// //     whatsappNumber = json['whatsapp_number'];
// //     email = json['email'];
// //     emailVerifiedAt = json['email_verified_at'];
// //     type = json['type'];
// //     status = json['status'];
// //     statusUser = json['status_user'];
// //     location = json['location'];
// //     country = json['country'];
// //     rate = json['rate'];
// //     notes = json['notes'];
// //     value = json['value'];
// //     // experienceYears = json['experience_years'];
// //     // visionary = json['visionary'];
// //     // objectives = json['objectives'];
// //     // typeLicense = json['type_license'];
// //     // licenseId = json['license_id'];
// //     // district = json['district'];
// //     // lan = json['lan'];
// //     // lat = json['lat'];
// //     // fcmToken = json['fcm_token'];
// //     // balance = json['balance'];
// //     createdAt = json['created_at'];
// //     updatedAt = json['updated_at'];
// //     promoted = json['promoted'];
// //     promotionBidDuration = json['promotion_bid_duration'];
// //     isBlocked = json['is_blocked'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['name'] = this.name;
// //     data['photo'] = this.photo;
// //     data['country_code'] = this.countryCode;
// //     data['phone'] = this.phone;
// //     data['whatsapp_number'] = this.whatsappNumber;
// //     data['email'] = this.email;
// //     data['email_verified_at'] = this.emailVerifiedAt;
// //     data['type'] = this.type;
// //     data['status'] = this.status;
// //     data['status_user'] = this.statusUser;
// //     data['location'] = this.location;
// //     data['country'] = this.country;
// //     data['rate'] = this.rate;
// //     data['notes'] = this.notes;
// //     data['value'] = this.value;
// //     // data['experience_years'] = this.experienceYears;
// //     // data['visionary'] = this.visionary;
// //     // data['objectives'] = this.objectives;
// //     // data['type_license'] = this.typeLicense;
// //     // data['license_id'] = this.licenseId;
// //     // data['district'] = this.district;
// //     // data['lan'] = this.lan;
// //     // data['lat'] = this.lat;
// //     // data['fcm_token'] = this.fcmToken;
// //     // data['balance'] = this.balance;
// //     data['created_at'] = this.createdAt;
// //     data['updated_at'] = this.updatedAt;
// //     data['promoted'] = this.promoted;
// //     data['promotion_bid_duration'] = this.promotionBidDuration;
// //     data['is_blocked'] = this.isBlocked;
// //     return data;
// //   }
// // }

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

class NotificationsLinks {
  String? url;
  String? label;
  bool? active;

  NotificationsLinks({this.url, this.label, this.active});

  NotificationsLinks.fromJson(Map<String, dynamic> json) {
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