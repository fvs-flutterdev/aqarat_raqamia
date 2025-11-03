// class ProfileModel {
//   UserProfile? userProfile;
//
//   ProfileModel({this.userProfile});
//
//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     userProfile = json['data'] != null ? new UserProfile.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.userProfile != null) {
//       data['data'] = this.userProfile!.toJson();
//     }
//     return data;
//   }
// }
//
// class UserProfile {
//   int? id;
//   String? name;
//   String? phone;
//   String? countryCode;
//   String? photo;
//   String? email;
//   String? type;
//   int? noRate;
//   String? status;
//   bool? isSubscribed;
//   String? statusUser;
//   String? location;
//   String? country;
//   double? rate;
//   String? notes;
//   String? value;
//   String? visionary;
//   String? objectives;
//   License? license;
//   String? district;
//   String? lan;
//   String? lat;
//   String? fcmToken;
//   String? experienceYears;
//   String? whatsappNumber;
//   List<String>? projects;
//   List<String>? achievements;
//   List<String>? imagesAlbum;
//   List<ServicesProfile>? services;
//   List<SubServices>? subServices;
//   List<Interests>? interests;
//   Wallet? wallet;
//
//   UserProfile(
//       {this.id,
//         this.name,
//         this.phone,
//         this.countryCode,
//         this.photo,
//         this.email,
//         this.type,
//         this.status,
//         this.statusUser,
//         this.isSubscribed,
//         this.location,
//         this.country,
//         this.rate,
//         this.noRate,
//         this.notes,
//         this.value,
//         this.visionary,
//         this.objectives,
//         this.license,
//         this.district,
//         this.lan,
//         this.lat,
//         this.fcmToken,
//         this.experienceYears,
//         this.whatsappNumber,
//         this.projects,
//         this.achievements,
//         this.imagesAlbum,
//         this.services,
//         this.subServices,
//         this.interests,
//         this.wallet});
//
//   UserProfile.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     phone = json['phone'];
//     countryCode = json['country_code'];
//     photo = json['photo'];
//     email = json['email'];
//     type = json['type'];
//     status = json['status'];
//     statusUser = json['status_user'];
//     isSubscribed = json['is_subscribed'];
//     location = json['location'];
//     country = json['country'];
//     rate = json['rate'];
//     noRate = json['noRate'];
//     notes = json['notes'];
//     value = json['value'];
//     visionary = json['visionary'];
//     objectives = json['objectives'];
//     license = json['license'];
//     district = json['district'];
//     lan = json['lan'];
//     lat = json['lat'];
//     fcmToken = json['fcm_token'];
//     experienceYears = json['experience_years'];
//     whatsappNumber = json['whatsapp_number'];
//     projects = json['projects'].cast<String>();
//     achievements = json['achievements'].cast<String>();
//     imagesAlbum = json['images_album'].cast<String>();
//     license =
//     json['license'] != null ? new License.fromJson(json['license']) : null;
//     if (json['services'] != null) {
//       services = <ServicesProfile>[];
//       json['services'].forEach((v) {
//         services!.add(new ServicesProfile.fromJson(v));
//       });
//     }
//     if (json['sub_services'] != null) {
//       subServices = <SubServices>[];
//       json['sub_services'].forEach((v) {
//         subServices!.add(new SubServices.fromJson(v));
//       });
//     }
//     if (json['interests'] != null) {
//       interests = <Interests>[];
//       json['interests'].forEach((v) {
//         interests!.add(new Interests.fromJson(v));
//       });
//     }
//     wallet =
//     json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['country_code'] = this.countryCode;
//     data['photo'] = this.photo;
//     data['email'] = this.email;
//     data['type'] = this.type;
//     data['status'] = this.status;
//     data['status_user'] = this.statusUser;
//     data['is_subscribed'] = this.isSubscribed;
//     data['location'] = this.location;
//     data['country'] = this.country;
//     data['rate'] = this.rate;
//     data['noRate'] = this.noRate;
//     data['notes'] = this.notes;
//     data['value'] = this.value;
//     data['visionary'] = this.visionary;
//     data['objectives'] = this.objectives;
//     data['license'] = this.license;
//     data['district'] = this.district;
//     data['lan'] = this.lan;
//     data['lat'] = this.lat;
//     data['fcm_token'] = this.fcmToken;
//     data['experience_years'] = this.experienceYears;
//     data['whatsapp_number'] = this.whatsappNumber;
//     data['projects'] = this.projects;
//     data['achievements'] = this.achievements;
//     data['images_album'] = this.imagesAlbum;
//     if (this.license != null) {
//       data['license'] = this.license!.toJson();
//     }
//     if (this.services != null) {
//       data['services'] = this.services!.map((v) => v.toJson()).toList();
//     }
//     if (this.subServices != null) {
//       data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
//     }
//     if (this.interests != null) {
//       data['interests'] = this.interests!.map((v) => v.toJson()).toList();
//     }
//     if (this.wallet != null) {
//       data['wallet'] = this.wallet!.toJson();
//     }
//     return data;
//   }
// }
//
// class ServicesProfile {
//   int? id;
//   String? name;
//   bool? istabbed;
//
//   ServicesProfile({this.id, this.name, this.istabbed});
//
//   ServicesProfile.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     istabbed = json['istabbed'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['istabbed'] = this.istabbed;
//     return data;
//   }
// }
//
// class Interests {
//   int? id;
//   String? name;
//   String? nameEn;
//   String? createdAt;
//   String? updatedAt;
//   Pivot? pivot;
//
//   Interests(
//       {this.id,
//         this.name,
//         this.nameEn,
//         this.createdAt,
//         this.updatedAt,
//         this.pivot});
//
//   Interests.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     nameEn = json['name_en'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['name_en'] = this.nameEn;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.pivot != null) {
//       data['pivot'] = this.pivot!.toJson();
//     }
//     return data;
//   }
// }
//
// class Pivot {
//   int? userId;
//   int? interestId;
//
//   Pivot({this.userId, this.interestId});
//
//   Pivot.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     interestId = json['interest_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['interest_id'] = this.interestId;
//     return data;
//   }
// }
// class SubServices {
//   int? id;
//   String? name;
//   bool? istabbed;
//
//   SubServices({this.id, this.name, this.istabbed});
//
//   SubServices.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     istabbed = json['istabbed'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['istabbed'] = this.istabbed;
//     return data;
//   }
// }
// class License {
//   int? id;
//   String? name;
//   bool? istabbed;
//
//   License({this.id, this.name, this.istabbed});
//
//   License.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     istabbed = json['istabbed'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['istabbed'] = this.istabbed;
//     return data;
//   }
// }
//
// class Wallet {
//   int? id;
//   int? userId;
//   String? balance;
//   String? createdAt;
//   String? updatedAt;
//
//   Wallet({this.id, this.userId, this.balance, this.createdAt, this.updatedAt});
//
//   Wallet.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     balance = json['balance'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['balance'] = this.balance;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }