class NotificationBody {
  String? serviceDetails;
  var requestServiceId;
  String? updatedAt;
  var userId;
  var price;
  String? createdAt;
  var commission;
  var id;
  String? bidDuration;

  NotificationBody(
      {this.serviceDetails,
      this.requestServiceId,
      this.updatedAt,
      this.userId,
      this.price,
      this.createdAt,
      this.commission,
      this.id,
      this.bidDuration});

  NotificationBody.fromJson(Map<String, dynamic> json) {
    serviceDetails = json['service_details'];
    requestServiceId = json['request_service_id'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    price = json['price'];
    createdAt = json['created_at'];
    commission = json['commission'];
    id = json['id'];
    bidDuration = json['bid_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_details'] = this.serviceDetails;
    data['request_service_id'] = this.requestServiceId;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['commission'] = this.commission;
    data['id'] = this.id;
    data['bid_duration'] = this.bidDuration;
    return data;
  }
}

class NotificationNewBody {
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
  String? body;
  String? title;
  String? senderId;

  /// id راسل الرساله / id الشخص الي هينفذ الخدمه
  NotificationNewBody({
    this.receiverId,
    this.chatRoomId,
    this.chatType,
    this.senderName,
    this.notificationType,
    this.body,
    this.title,
    this.senderId,
  });

  NotificationNewBody.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiver_id'];
    chatRoomId = json['chat_room_id'];
    chatType = json['msg_type'];
    senderName = json['sender_name'];
    body = json['body'];
    notificationType = json['type'];
    title = json['title'];
    senderId = json['sender_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiver_id'] = this.receiverId;
    data['chat_room_id'] = this.chatRoomId;
    data['msg_type'] = this.chatType;
    data['sender_name'] = this.senderName;
    data['type'] = this.notificationType;
    data['body'] = this.body;
    data['title'] = this.title;
    data['sender_id'] = this.senderId;
    return data;
  }
}
