class ProviderSummaryModel {
  Provider? provider;

  ProviderSummaryModel({this.provider});

  ProviderSummaryModel.fromJson(Map<String, dynamic> json) {
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    return data;
  }
}

class Provider {
  int? pendingRequests;
  int? acceptedRequests;
  int? finishedRequests;
  int? priceOffersNotAccepted;
  ProviderRequests? providerRequests;
  List<Subscriptions>? subscriptions;

  Provider(
      {this.pendingRequests,
        this.acceptedRequests,
        this.finishedRequests,
        this.priceOffersNotAccepted,
        this.providerRequests,
        this.subscriptions});

  Provider.fromJson(Map<String, dynamic> json) {
    pendingRequests = json['pending_requests'];
    acceptedRequests = json['accepted_requests'];
    finishedRequests = json['finished_requests'];
    priceOffersNotAccepted = json['price_offers_not_accepted'];
    providerRequests = json['provider_requests'] != null
        ? new ProviderRequests.fromJson(json['provider_requests'])
        : null;
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(new Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending_requests'] = this.pendingRequests;
    data['accepted_requests'] = this.acceptedRequests;
    data['finished_requests'] = this.finishedRequests;
    data['price_offers_not_accepted'] = this.priceOffersNotAccepted;
    if (this.providerRequests != null) {
      data['provider_requests'] = this.providerRequests!.toJson();
    }
    if (this.subscriptions != null) {
      data['subscriptions'] =
          this.subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProviderRequests {
  int? pendingRequests;
  int? acceptedRequests;
  int? finishedRequests;

  ProviderRequests(
      {this.pendingRequests, this.acceptedRequests, this.finishedRequests});

  ProviderRequests.fromJson(Map<String, dynamic> json) {
    pendingRequests = json['pending_requests'];
    acceptedRequests = json['accepted_requests'];
    finishedRequests = json['finished_requests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending_requests'] = this.pendingRequests;
    data['accepted_requests'] = this.acceptedRequests;
    data['finished_requests'] = this.finishedRequests;
    return data;
  }
}

class Subscriptions {
  int? subscriptionId;
  String? subscriptionName;
  String? expirationDate;
  String? price;
  String? type;
  bool? isExpired;

  Subscriptions(
      {this.subscriptionId,
        this.subscriptionName,
        this.expirationDate,
        this.price,
        this.type,
        this.isExpired});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscription_id'];
    subscriptionName = json['subscription_name'];
    expirationDate = json['expiration_date'];
    price = json['price'];
    type = json['type'];
    isExpired = json['is_expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscription_id'] = this.subscriptionId;
    data['subscription_name'] = this.subscriptionName;
    data['expiration_date'] = this.expirationDate;
    data['price'] = this.price;
    data['type'] = this.type;
    data['is_expired'] = this.isExpired;
    return data;
  }
}