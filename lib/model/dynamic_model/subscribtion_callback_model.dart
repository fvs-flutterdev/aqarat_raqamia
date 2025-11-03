class SubscriptionCallBackModel {
  String? id;
  String? url;
  Reference? reference;
  String? callbackUrl;
  String? apiKey;

  SubscriptionCallBackModel(
      {this.id, this.url, this.reference, this.callbackUrl, this.apiKey});

  SubscriptionCallBackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    reference = json['reference'] != null
        ? new Reference.fromJson(json['reference'])
        : null;
    callbackUrl = json['callback_url'];
    apiKey = json['api_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    if (this.reference != null) {
      data['reference'] = this.reference!.toJson();
    }
    data['callback_url'] = this.callbackUrl;
    data['api_key'] = this.apiKey;
    return data;
  }
}

class Reference {
  String? transaction;
  String? order;

  Reference({this.transaction, this.order});

  Reference.fromJson(Map<String, dynamic> json) {
    transaction = json['transaction'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction'] = this.transaction;
    data['order'] = this.order;
    return data;
  }
}